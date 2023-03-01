<?php

namespace Drupal\Tests\sec_activity_tracker\Unit;

use Drupal\Tests\UnitTestCase;
use Drupal\sec_activity_tracker\SecActivitySubscriber;
use Drupal\core_event_dispatcher\Event\Entity\EntityUpdateEvent;
use Drupal\core_event_dispatcher\Event\Entity\EntityinsertEvent;
use Drupal\core_event_dispatcher\Event\Entity\EntitydeleteEvent;

/**
 * Test the Subscriber class from ec_activity_tracker which is used.
 *
 * @coversDefaultClass Drupal\sec_activity_tracker\SecActivitySubscriber
 * @group              sec_activity_tracker
 * @group              sec
 */

class SecActivitySubscriberTest extends UnitTestCase
{
    /**
     * The class we need to test.
     *
     * @var \Drupal\sec_activity_tracker\SecActivitySubscriber
     */

    /**
     * The SecActivitySubscriber instance.
     *
     * @var \Drupal\sec_activity_tracker\SecActivitySubscriber
     */
    private $_secActivitySubscriber;

    /**
     * The EntityUpdateEvent instance.
     *
     * @var \Drupal\core_event_dispatcher\Event\Entity\EntityUpdateEvent
     */
    private $_entityUpdateEvent;

    /**
     * The EntityinsertEvent instance.
     *
     * @var \Drupal\core_event_dispatcher\Event\Entity\EntityinsertEvent
     */

    private $_entityInsertEvent;

    /**
     * The EntitydeleteEvent instance.
     *
     * @var \Drupal\core_event_dispatcher\Event\Entity\EntitydeleteEvent
     */
    private $_entityDeleteEvent;

    /**
     * The Entity Mock object.
     *
     * @var \Drupal\Core\Entity\EntityInterface
     */

    private $_entity;

    /**
     * {@inheritdoc}
     */
    protected function setUp()
    {
        $this->markTestIncomplete("Due to database interaction we are skipping this test file.");
        $this->_secActivitySubscriber = new SecActivitySubscriber();
        $this->_entity = $this->createMock('Drupal\Core\Entity\EntityInterface');
        $this->_entityUpdateEvent = new EntityUpdateEvent($this->_entity);
        $this->_entityInsertEvent = new EntityinsertEvent($this->_entity);
        $this->_entityDeleteEvent = new EntitydeleteEvent($this->_entity);
    }
    /**
     * @covers ::updateEntity
   */
    public function testUpdateEntity()
    {
        $this->_secActivitySubscriber->updateEntity($this->_entityUpdateEvent);
    }

    /**
     * @covers ::insertEntity
     */
    public function testInsertEntity()
    {
        $this->_secActivitySubscriber->updateEntity($this->_entityUpdateEvent);
    }

    /**
     * @covers ::deleteEntity
     */
    public function testDeleteEntity()
    {
        $this->_secActivitySubscriber->updateEntity($this->_entityUpdateEvent);
    }
}
