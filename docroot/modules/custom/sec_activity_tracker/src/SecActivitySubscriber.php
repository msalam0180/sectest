<?php

/**
 * @file
 * Contains \Drupal\sec_activity_tracker\SecActivitySubscriber
 */

namespace Drupal\sec_activity_tracker;

use Drupal\Core\Url;
use Symfony\Component\HttpKernel\KernelEvents;
use Symfony\Cmf\Component\Routing\RouteObjectInterface;
use Symfony\Component\HttpKernel\Event\RequestEvent;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

use Drupal\core_event_dispatcher\Event\Form\FormAlterEvent;
use Drupal\core_event_dispatcher\Event\Entity\EntityInsertEvent;
use Drupal\core_event_dispatcher\Event\Entity\EntityUpdateEvent;
use Drupal\core_event_dispatcher\Event\Entity\EntityDeleteEvent;
use Drupal\core_event_dispatcher\EntityHookEvents;
use Drupal\core_event_dispatcher\FormHookEvents;
use Drupal\user\Entity\User;
use Drupal\taxonomy\Entity\Term;
use Drupal\core\Database\Database;

/**
 * Subscribes to the event_dispatcher events.
 * Symfony\Component\EventDispatcher\EventSubscriberInterface $event
 */

class SecActivitySubscriber implements EventSubscriberInterface {

  /**
   * @param \Drupal\core_event_dispatcher\Event\Entity\EntityUpdateEvent $event
   */
  public function updateEntity(EntityUpdateEvent $event) {
    $this->_setActivityData($event);
  }

  /**
   * @param \Drupal\core_event_dispatcher\Event\Entity\EntityInsertEvent $event
   */

  public function insertEntity(EntityInsertEvent $event) {
    $this->_setActivityData($event);
  }

  /**
   * @param \Drupal\core_event_dispatcher\Event\Entity\EntityDeleteEvent $event
   */

  public function deleteEntity(EntityDeleteEvent $event) {
    $this->_setActivityData($event);
  }

  /**
   * @param \Drupal\core_event_dispatcher\Event\Form\FormAlterEvent $event
   */
  public function alterForm(FormAlterEvent $event) {
    $form = &$event->getForm();
    if ($form["#id"] == "views-exposed-form-sec-user-activity-log-page-1") {
      $form['created_wrapper']['created']['min']['#title'] = t('from:');
      $form['created_wrapper']['created']['max']['#title'] = t('to:');

      $form['changed_wrapper']['changed']['min']['#title'] = t('from:');
      $form['changed_wrapper']['changed']['max']['#title'] = t('to:');

      $form['items_per_page']['#title'] = "<br> Items per page";
    }
  }

  /**
   * Overrides the content and serves a 404 status code.
   *
   *  @param \Symfony\Component\HttpKernel\Event\RequestEvent $event
   *  The response event, which we will take over like a boss.
   */

  public function checkForCustomRedirect(RequestEvent $event) {
    $route_name = \Drupal::request()->attributes->get(RouteObjectInterface::ROUTE_NAME);
    if ($route_name === 'sec_admin_content.contentSearch') {
      // drupal_set_message('Redirect worked!. You are all set.');
      $event->setResponse(new RedirectResponse(Url::fromRoute('view.content.page_2')->toString()));
    }
  }

  private function _setActivityData($event) {
    //Check is the action being profromed is 'node';
    $entity = $event->getEntity();
    $conn = Database::getConnection();
    if ($entity->getEntityTypeId() !== 'node') {
      return;
    }

    switch ($event->getDispatcherType()) {
      case 'hook_event_dispatcher.entity.insert':
        if (!$entity->isPublished()) {
          $action = 'created';
        } else {
          $action = 'publish';
        }
        break;
      case 'hook_event_dispatcher.entity.update':
        if (!$entity->isPublished()) {
          $action = 'edit';
        } else {
          $action = 'publish';
        }
        break;
      case 'hook_event_dispatcher.entity.delete':
        $action = 'delete';
        break;
      default:
        $action = 'not set';
        break;
    }
    $uid = \Drupal::currentUser()->id();
    $user = User::load($uid);
    if ($entity->hasField('field_primary_division_office')) {
      $taxonomyEntity = $entity->field_primary_division_office->getValue();
      $taxonomy = isset($taxonomyEntity[0]) ? Term::load($taxonomyEntity[0]['target_id']) : null;
      if ($taxonomy && method_exists($taxonomy, 'getName')) {
        $divisionOffice = $taxonomy->getName();
      }
    }

    try {
      $conn->insert('sec_activity_tracker')->fields(
        [
          'uid' => $uid,
          'nid' => $entity->id(),
          'name' => $user->getDisplayName(),
          'title' => $entity->getTitle(),
          'type' => $entity->getType(),
          'role' => '',
          'action' => $action,
          'division_office' => isset($divisionOffice) ? $divisionOffice : null,
          'created' => $entity->isNew() ? \Drupal::time()->getRequestTime() : $entity->getCreatedTime(),
          'changed' =>  \Drupal::time()->getRequestTime(),
        ]
      )->execute();
    } catch (\Exception $e) {
      // Log an error.
      \Drupal::logger('sec_activity_tracker')->error($e);
    }
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
        KernelEvents::REQUEST => 'checkForCustomRedirect',
        EntityHookEvents::ENTITY_INSERT => 'insertEntity',
        EntityHookEvents::ENTITY_UPDATE => 'updateEntity',
        EntityHookEvents::ENTITY_DELETE => 'deleteEntity',
        FormHookEvents::FORM_ALTER => 'alterForm',
      ];
    } else {
      return [];
    }
  }
}
