<?php

namespace Drupal\Tests\workbench_moderation\Kernel;

use Drupal\KernelTests\KernelTestBase;
use Drupal\workbench_moderation\Entity\ModerationState;
use Drupal\node\Entity\Node;
use Drupal\node\Entity\NodeType;

/**
 * Class EntityOperationsTest.
 *
 * @coversDefaultClass \Drupal\workbench_moderation\EntityOperations
 * @group workbench_moderation
 */
class EntityOperationsTest extends KernelTestBase {

  /**
   * {@inheritdoc}
   */
  protected static $modules = [
    'workbench_moderation',
    'node',
    'views',
    'options',
    'user',
    'system',
  ];

  /**
   * {@inheritdoc}
   */
  protected function setUp(): void {
    parent::setUp();
    $this->installEntitySchema('node');
    $this->installSchema('node', 'node_access');
    $this->installEntitySchema('user');
    $this->installConfig('workbench_moderation');

    $this->createNodeType();
  }

  /**
   * Creates a page node type to test with, ensuring that it's moderatable.
   */
  protected function createNodeType() {
    $node_type = NodeType::create([
      'type' => 'page',
      'label' => 'Page',
    ]);
    $node_type->setThirdPartySetting('workbench_moderation', 'enabled', TRUE);
    $node_type->save();
  }

  /**
   * Verifies that the process of saving forward-revisions works as expected.
   */
  public function testForwardRevisions() {
    // Create a new node in draft.
    $page = Node::create([
      'type' => 'page',
      'title' => 'A',
    ]);
    $page->moderation_state->target_id = 'draft';
    $page->save();

    $id = $page->id();

    // Verify the entity saved correctly, and that the presence of forward
    // revisions doesn't affect the default node load.
    /** @var \Drupal\node\Entity\Node $page */
    $page = Node::load($id);
    $this->assertEquals('A', $page->getTitle());
    $this->assertTrue($page->isDefaultRevision());
    $this->assertFalse($page->isPublished());

    // Moderate the entity to published.
    $page->setTitle('B');
    $page->moderation_state->target_id = 'published';
    $page->save();

    // Verify the entity is now published and public.
    $page = Node::load($id);
    $this->assertEquals('B', $page->getTitle());
    $this->assertTrue($page->isDefaultRevision());
    $this->assertTrue($page->isPublished());

    // Make a new forward-revision in Draft.
    $page->setTitle('C');
    $page->moderation_state->target_id = 'draft';
    $page->save();

    // Verify normal loads return the still-default previous version.
    $page = Node::load($id);
    $this->assertEquals('B', $page->getTitle());

    // Verify we can load the forward revision, even if the mechanism is kind
    // of gross. Note: revisionIds() is only available on NodeStorageInterface,
    // so this won't work for non-nodes. We'd need to use entity queries. This
    // is a core bug that should get fixed.
    $storage = \Drupal::entityTypeManager()->getStorage('node');
    $revision_ids = $storage->revisionIds($page);
    sort($revision_ids);
    $latest = end($revision_ids);
    $page = $storage->loadRevision($latest);
    $this->assertEquals('C', $page->getTitle());

    $page->setTitle('D');
    $page->moderation_state->target_id = 'published';
    $page->save();

    // Verify normal loads return the still-default previous version.
    $page = Node::load($id);
    $this->assertEquals('D', $page->getTitle());
    $this->assertTrue($page->isDefaultRevision());
    $this->assertTrue($page->isPublished());

    // Now check that we can immediately add a new published revision over it.
    $page->setTitle('E');
    $page->moderation_state->target_id = 'published';
    $page->save();

    $page = Node::load($id);
    $this->assertEquals('E', $page->getTitle());
    $this->assertTrue($page->isDefaultRevision());
    $this->assertTrue($page->isPublished());
  }

  /**
   * Verifies that a newly-created node can go straight to published.
   */
  public function testPublishedCreation() {
    // Create a new node in draft.
    $page = Node::create([
      'type' => 'page',
      'title' => 'A',
    ]);
    $page->moderation_state->target_id = 'published';
    $page->save();

    $id = $page->id();

    // Verify the entity saved correctly.
    /** @var \Drupal\node\Entity\Node $page */
    $page = Node::load($id);
    $this->assertEquals('A', $page->getTitle());
    $this->assertTrue($page->isDefaultRevision());
    $this->assertTrue($page->isPublished());
  }

  /**
   * Verifies that an unpublished state may be made the default revision.
   */
  public function testArchive() {
    $published_id = $this->randomMachineName();
    $published_state = ModerationState::create([
      'id' => $published_id,
      'label' => $this->randomString(),
      'published' => TRUE,
      'default_revision' => TRUE,
    ]);
    $published_state->save();

    $archived_id = $this->randomMachineName();
    $archived_state = ModerationState::create([
      'id' => $archived_id,
      'label' => $this->randomString(),
      'published' => FALSE,
      'default_revision' => TRUE,
    ]);
    $archived_state->save();

    $page = Node::create([
      'type' => 'page',
      'title' => $this->randomString(),
    ]);
    $page->moderation_state->target_id = $published_id;
    $page->save();

    $id = $page->id();

    // The newly-created page should already be published.
    $page = Node::load($id);
    $this->assertTrue($page->isPublished());

    // When the page is moderated to the archived state, then the latest
    // revision should be the default revision, and it should be unpublished.
    $page->moderation_state->target_id = $archived_id;
    $page->save();
    $new_revision_id = $page->getRevisionId();

    $storage = \Drupal::entityTypeManager()->getStorage('node');
    $new_revision = $storage->loadRevision($new_revision_id);
    $this->assertFalse($new_revision->isPublished());
    $this->assertTrue($new_revision->isDefaultRevision());
  }

}
