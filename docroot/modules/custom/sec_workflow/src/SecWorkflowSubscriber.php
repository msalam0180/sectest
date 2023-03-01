<?php

/**
 * @file
 * Contains \Drupal\sec_workflow\SecWorkflowSubscriber
 */

namespace Drupal\sec_workflow;

use Drupal\user\Entity\Role;
use Drupal\user\Entity\User;
use \Drupal\Core\Url;
use Symfony\Component\HttpKernel\KernelEvents;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;
use Symfony\Cmf\Component\Routing\RouteObjectInterface;
use Symfony\Component\HttpKernel\Event\RequestEvent;

//Using hook_event_dispatcher;
use Drupal\core_event_dispatcher\Event\Entity\EntityViewEvent;
use Drupal\core_event_dispatcher\Event\Entity\EntityInsertEvent;
use Drupal\core_event_dispatcher\Event\Entity\EntityUpdateEvent;
use Drupal\core_event_dispatcher\Event\Form\FormAlterEvent;
use Drupal\core_event_dispatcher\EntityHookEvents;
use Drupal\core_event_dispatcher\FormHookEvents;
use Drupal\Core\Session\AccountInterface;

/**
 * Subscribes to the event_dispatcher events.
 * Symfony\Component\EventDispatcher\EventSubscriberInterface $event
 */

class SecWorkflowSubscriber implements EventSubscriberInterface {

  /**
   * Overrides the workflow for content_creator to allow publishing/unpublishing
   * of new image/link content types.
   *
   *  @param \Symfony\Component\HttpKernel\Event\RequestEvent $event
   *  The response event, which we will take over like a boss.
   */

  public function updateUserRoles(RequestEvent $event) {
    $currentUrl = \Drupal::service('path.current')->getPath();
    $path = explode('/', $currentUrl);
    $currentUser = \Drupal::currentUser();
    if ($currentUser->isAuthenticated() && in_array('content_creator', $currentUser->getRoles()) && in_array('node', $path)) {
      $withoutModstate = ['image', 'link'];
      $role = Role::load('content_creator');
      $node = is_object(\Drupal::routeMatch()->getParameter('node')) ? \Drupal::routeMatch()->getParameter('node')->bundle() : NULL;
      if ((!empty(array_intersect($withoutModstate, $path)) && in_array('add', $path)) || (in_array('edit', $path) && ($node == 'link'))) {
        $role->grantPermission('use archived_published transition');
        $role->grantPermission('use published_archived transition');
        $role->grantPermission('use published_published transition');
      } else {
        $role->revokePermission('use archived_published transition');
        $role->revokePermission('use published_archived transition');
        $role->revokePermission('use published_published transition');
      }
      $role->save();
    }
  }

  /**
   * @param \Drupal\core_event_dispatcher\Event\Form\FormAlterEvent $event
   */

  public function alterForm(FormAlterEvent $event) {
    $form = &$event->getForm();
    // Immediately return if approver || creator !exist;
    if (empty($form['field_sec_content_approver']) && empty($form['field_creator'])) {
      return;
    }

    $userRoles = \Drupal::currentUser()->getRoles();
    // if ($form['#entity_type'] === "node") {
    //   $form['#attached']['library'][] = 'sec_workflow/sec_workflow';
    // };

    $fieldContentApprover = !empty($form['field_sec_content_approver']) ? $form['field_sec_content_approver'] : null;
    $fieldContentCreator =  !empty($form['field_creator']) ? $form['field_creator'] : null;
    unset($form['field_sec_content_approver']);
    unset($form['field_creator']);

    //Set up our admin group setting
    $form['content_workflow'] = [
      '#type' => "details",
      '#open' => true,
      '#title' => t('Workflow Options'),
      '#group' => 'advanced',
      '#tree' => true,
    ];

    $approvedRoles = ['administrator', 'content_approver', 'division_office_admin'];

    if (count(array_intersect($approvedRoles, $userRoles)) > 0) {
      $form['content_workflow'][] = $fieldContentApprover;
      $form['content_workflow'][] = $fieldContentCreator;
    } elseif (in_array('content_creator', $userRoles)) {
      $form['content_workflow'][] = $fieldContentApprover;
    }
  }

  /**
   * @param \Drupal\core_event_dispatcher\Event\Entity\EntityUpdateEvent $event
   */

  public function updateEntity(EntityUpdateEvent $event) {
    $this->_secMailManagerSend($event);
  }

  /**
   * @param \Drupal\core_event_dispatcher\Event\Entity\EntityInsertEvent $event
   */

  public function insertEntity(EntityInsertEvent $event) {
    $this->_secMailManagerSend($event);
  }

  /**
   * [_secMailManagerSend description]
   *
   * @param [type] $event [EntityUpdateEvent $event]
   */
  private function _secMailManagerSend($event) {
    $entity = $event->getEntity();

    if ($entity->getEntityTypeId() !== "node") {
      return;
    }

    if (!$entity->hasField('field_sec_content_approver') && !$entity->hasField('field_creator')) {
      return;
    }

    $cState = null;
    $oState = null;
    $cState = null;

    if (isset($entity->moderation_state) && isset($entity->moderation_state->getValue()[0]['target_id'])) {
      $cState = $entity->hasField('moderation_state') ? $entity->moderation_state->getValue()[0]['target_id'] : null;
    }
    if (isset($entity->original->moderation_state) && isset($entity->original->moderation_state->getValue()[0]['target_id'])) {
      $oState = $entity->original !== null ? $entity->original->moderation_state->getValue()[0]['target_id'] : null;
    }

    if (isset($oState[0]['target_id'])) {
      $originalState = $oState[0]['target_id'];
    }

    if (isset($cState[0]['target_id'])) {
      $currentState = $cState[0]['target_id'];
    }

    $userRoles = \Drupal::currentUser()->getRoles();
    $approvedRoles = ['administrator', 'content_approver', 'division_office_admin'];
    $combinedStates = rtrim($oState . '--->' . $cState);
    switch ($combinedStates) {
      case 'published--->published':
      case '--->draft':
      case '--->published':
      case 'published--->archived':
      case 'archived--->published':
      case 'needs_review--->needs_review':
        return;
        break;

      case '--->needs_review':
      case 'published--->needs_review':
      case 'draft--->needs_review':
        $users = $entity->get('field_sec_content_approver')->getValue();
        $address = \Drupal::request()->getHost() . $entity->toUrl()->toString();;
        if (!empty($entity->get('field_sec_content_approver')->getValue()[0]['target_id'])) {
          $approver = $this->getNameByuid($entity->get('field_sec_content_approver')->getValue()[0]['target_id']);
        } else {
          $approver = "User";
        }
        $params['subject'] = t(
          'Request: Content @title is Ready for Review and Approval',
          ['@title' => $entity->label()]
        );
        $params['message'] = t(
          "
            <p>@user,</p>
            <br/><p>The following content has been submitted for review and Approval in Drupal CMS by @name.</p>
            <br/>Content: @title
            <br/>Comments: @revlog
            <br/>URL: <a href='@url'>@title</a>",
          [
            '@name' => \Drupal::currentUser()->getAccountName(),
            '@title' => $entity->label(),
            '@revlog' => !empty($entity->revision_log->getValue()[0]['value']) ? $entity->revision_log->getValue()[0]['value'] : '',
            '@url' => $address,
            '@user' => $approver
          ]
        );
        break;

      case 'published--->draft':
      case 'needs_review--->draft':
        $users = $entity->get('field_creator')->getValue();
        $address = \Drupal::request()->getHost() . $entity->toUrl()->toString();;
        if (!empty($entity->get('field_creator')->getValue()[0]['target_id'])) {
          $creator = $this->getNameByuid($entity->get('field_creator')->getValue()[0]['target_id']);
        } else {
          $creator = "User";
        }
        $params['subject'] = t(
          'Request: Content @title has been disapproved and sent back for re-editing',
          ['@title' => $entity->label()]
        );
        $params['message'] = t(
          "<p>@user,</p>
            <br/><p>The following content has been reviewed and sent back to draft for edit in Drupal CMS by @name.</p>
            <br/>Content: @title
            <br/>Comments: @revlog
            <br/>URL: <a href='@url'>@title</a>",
          [
            '@name' => \Drupal::currentUser()->getAccountName(),
            '@title' => $entity->label(),
            '@revlog' => !empty($entity->revision_log->getValue()[0]['value']) ? $entity->revision_log->getValue()[0]['value'] : '',
            '@url' => $address,
            '@user' => $creator
          ]
        );
    }

    $uids = [];
    $userMail = [];
    //Get all the Uid's from the cuttent approver list;
    if (isset($users)) {
      foreach ($users as $key => $user) {
        $uids[] = $user['target_id'];
      }
    }

    if (empty($uids)) {
      return;
    }
    //Load all requestired user object and get email values;
    $accounts = User::loadMultiple($uids);
    foreach ($accounts as $uid => $UserObject) {
      $userMail[] = $UserObject->getEmail();
    }
    //Setup MailManager service for email notification;
    $mailManager = \Drupal::service('plugin.manager.mail');
    $module = 'sec_workflow';
    $key = 'sec_content_workflow';
    $to = rtrim(implode(",", $userMail), ',');
    $langcode = \Drupal::currentUser()->getPreferredLangcode();
    $send = true;

    $result = $mailManager->mail($module, $key, $to, $langcode, $params, null, $send);

    if ($result['result'] !== true) {
      $message = t('There was a problem sending your email notification to @email for creating article @label.', ['@email' => $to, '@label' => $entity->label()]);
      \Drupal::messenger()->addError($message);
      \Drupal::logger('SEC Workflow')->error($message);
      return;
    } else {
      $message = t('An email notification has been sent to @email for review article @label.', ['@email' => $to, '@label' => $entity->label()]);
      \Drupal::messenger()->addStatus($message);
      \Drupal::logger('SEC Workflow')->notice($message);
    }
  }

  public function getNameByuid($uid) {
    $account = User::load($uid); // pass your uid
    $name = $account->getAccountName();
    return $name;
  }

  /**
   * {@inheritdoc}
   */
  public static function getSubscribedEvents() {
    if (
      class_exists('\Symfony\Component\HttpKernel\KernelEvents') &&
      class_exists('\Drupal\core_event_dispatcher\EntityHookEvents') &&
      class_exists('\Drupal\core_event_dispatcher\FormHookEvents')
    ) {
      return [
        KernelEvents::REQUEST => 'updateUserRoles',
        FormHookEvents::FORM_ALTER => 'alterForm',
        EntityHookEvents::ENTITY_UPDATE => 'updateEntity',
        EntityHookEvents::ENTITY_INSERT => 'insertEntity',
      ];
    } else {
      return [];
    }
  }
}
