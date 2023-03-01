<?php

namespace Drupal\investor_replicate_settings\EventSubscriber;

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

class InvestorReplicateSettingsNode implements EventSubscriberInterface {

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


    // Example field value reset
    // if ($cloned_entity->hasField('field_date')) {
    //   $cloned_entity->set('field_date', NULL);
    // }


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
