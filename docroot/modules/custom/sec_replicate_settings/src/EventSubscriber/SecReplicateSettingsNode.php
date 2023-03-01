<?php

namespace Drupal\sec_replicate_settings\EventSubscriber;

use Drupal\node\Entity\Node;
use Drupal\replicate\Events\ReplicateAlterEvent;
use Drupal\replicate\Events\ReplicatorEvents;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

/**
   * Sets various values for the replicated node to current user, time and other sensible defaults.
   *
   * @param \Drupal\replicate\Events\ReplicateAlterEvent $event
   *  The event fired by the replicator.
   *  For more details look at replicate_api doc.
 */

class SecReplicateSettingsNode implements EventSubscriberInterface {

  public function setSettings(ReplicateAlterEvent $event) {
    $cloned_entity = $event->getEntity();

    if (!$cloned_entity instanceof Node) {
      return;
    }

    $currentUserId = \Drupal::currentUser()->id();
    $currentTime = \Drupal::time()->getCurrentTime();

    $cloned_entity->setOwnerId($currentUserId);
    $cloned_entity->setCreatedTime($currentTime);

    $cloned_entity->setRevisionUserId($currentUserId);
    $cloned_entity->setRevisionCreationTime($currentTime);

    if ($cloned_entity->hasField('field_sec_content_approver')) {
      $cloned_entity->set('field_sec_content_approver', NULL);
    }
    if ($cloned_entity->hasField('field_creator')) {
      $cloned_entity->set('field_creator', NULL);
    }
    if ($cloned_entity->hasField('field_date')) {
      $cloned_entity->set('field_date', NULL);
    }
    if ($cloned_entity->hasField('field_release_number')) {
      $cloned_entity->set('field_release_number', NULL);
    }
    if ($cloned_entity->hasField('field_judgment_date')) {
      $cloned_entity->set('field_judgment_date', NULL);
    }
    if ($cloned_entity->hasField('field_publish_date')) {
      $date = new \DateTime("now",new \DateTimeZone('UTC'));
      $cloned_entity->set('field_publish_date', $date->format("Y-m-d\TH:i:s"));
    }
    if ($cloned_entity->hasField('field_sec_event_date')) {
      $date = new \DateTime("now",new \DateTimeZone('UTC'));
      $cloned_entity->set('field_sec_event_date', $date->format("Y-m-d\TH:i:s"));
    }
    if ($cloned_entity->hasField('field_sec_event_end_date')) {
      $end_date = date("Y-m-d\TH:i:s", mktime(27, 59, 59)); // relates to GMT: Greenwich Mean Time
      $cloned_entity->set('field_sec_event_end_date', $end_date);
    }
    if ($cloned_entity->hasField('promote')) {
      $cloned_entity->set('promote', false);
    }
    if ($cloned_entity->hasField('sticky')) {
      $cloned_entity->set('sticky', false);
    }


    $cloned_entity->setPublished(FALSE);
    $cloned_entity->set('moderation_state', 'draft');

  }


  /**
   * {@inheritdoc}
   */
  public static function getSubscribedEvents() {
    $events = [];
    $events[ReplicatorEvents::REPLICATE_ALTER][] = 'setSettings';
    return $events;
  }
}
