<?php

namespace Drupal\Tests\workbench_moderation\Functional;

use Drupal\node\Entity\Node;
use Drupal\Tests\BrowserTestBase;
use Drupal\Tests\workbench_moderation\Traits\WorkbenchModerationTestTrait;

/**
 * Tests the view access control handler for moderation state entities.
 *
 * @group workbench_moderation
 *
 * @runTestsInSeparateProcesses
 *
 * @preserveGlobalState disabled
 */
class ModerationStateAccessTest extends BrowserTestBase {

  use WorkbenchModerationTestTrait;

  /**
   * {@inheritdoc}
   */
  protected $defaultTheme = 'stark';

  /**
   * {@inheritdoc}
   */
  protected static $modules = [
    'workbench_moderation_test_views',
    'workbench_moderation',
    'node',
    'views',
    'options',
    'user',
    'system',
  ];

  /**
   * Test the view operation access handler with the view permission.
   */
  public function testViewShowsCorrectStates() {
    $node_type_id = 'test';
    $node_type = $this->createNodeType('Test', $node_type_id);

    $permissions = [
      'access content',
      'view all revisions',
      'view moderation states',
    ];
    $editor1 = $this->drupalCreateUser($permissions);
    $this->drupalLogin($editor1);

    /** @var \Drupal\node\Entity\Node $node_1 */
    $node_1 = Node::create([
      'type' => $node_type_id,
      'title' => 'Draft node',
      'uid' => $editor1->id(),
    ]);
    $node_1->moderation_state->target_id = 'draft';
    $node_1->save();

    /** @var \Drupal\node\Entity\Node $node_2 */
    $node_2 = Node::create([
      'type' => $node_type_id,
      'title' => 'Review node',
      'uid' => $editor1->id(),
    ]);
    $node_2->moderation_state->target_id = 'needs_review';
    $node_2->save();

    /** @var \Drupal\node\Entity\Node $node_3 */
    $node_3 = Node::create([
      'type' => $node_type_id,
      'title' => 'Published node',
      'uid' => $editor1->id(),
    ]);
    $node_3->moderation_state->target_id = 'published';
    $node_3->save();

    // Resave the node with a new state.
    $node_3->setTitle('Archived node');
    $node_3->moderation_state->target_id = 'archived';
    $node_3->save();

    // Now show the View, and confirm that the state labels are showing.
    $this->drupalGet('/latest');
    $page = $this->getSession()->getPage();
    $this->assertTrue($page->hasLink('Draft'));
    $this->assertTrue($page->hasLink('Needs Review'));
    $this->assertTrue($page->hasLink('Archived'));
    $this->assertFalse($page->hasLink('Published'));

    // Now log in as an admin and test the same thing.
    $permissions = [
      'access content',
      'view all revisions',
      'administer moderation states',
    ];
    $admin1 = $this->drupalCreateUser($permissions);
    $this->drupalLogin($admin1);

    $this->drupalGet('/latest');
    $page = $this->getSession()->getPage();
    $this->assertEquals(200, $this->getSession()->getStatusCode());
    $this->assertTrue($page->hasLink('Draft'));
    $this->assertTrue($page->hasLink('Needs Review'));
    $this->assertTrue($page->hasLink('Archived'));
    $this->assertFalse($page->hasLink('Published'));
  }

}
