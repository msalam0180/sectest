<?php

namespace Drupal\Tests\workbench_moderation\Functional;

use Drupal\Core\Url;
use Drupal\node\Entity\Node;

/**
 * Tests general content moderation workflow for nodes.
 *
 * @group workbench_moderation
 */
class ModerationStateNodeTest extends ModerationStateTestBase {

  /**
   * {@inheritdoc}
   */
  protected function setUp(): void {
    parent::setUp();
    $this->drupalLogin($this->adminUser);
    $this->createContentTypeFromUi('Moderated content', 'moderated_content', TRUE, [
      'draft',
      'needs_review',
      'published',
    ], 'draft');
    $this->grantUserPermissionToCreateContentOfType($this->adminUser, 'moderated_content');
  }

  /**
   * Tests creating and deleting content.
   */
  public function testCreatingContent() {
    $this->drupalGet('node/add/moderated_content');
    $this->submitForm([
      'title[0][value]' => 'moderated content',
    ], t('Save and Create New Draft'));
    $nodes = \Drupal::entityTypeManager()
      ->getStorage('node')
      ->loadByProperties([
        'title' => 'moderated content',
      ]);

    if (!$nodes) {
      $this->fail('Test node was not saved correctly.');
      return;
    }

    $node = reset($nodes);

    $path = 'node/' . $node->id() . '/edit';
    $this->drupalGet($path);
    // Set up needs review revision.
    $this->submitForm([], t('Save and Request Review'));
    $this->drupalGet($path);
    // Set up published revision.
    $this->submitForm([], t('Save and Publish'));
    \Drupal::entityTypeManager()->getStorage('node')->resetCache([$node->id()]);
    /* @var \Drupal\node\NodeInterface $node */
    $node = \Drupal::entityTypeManager()->getStorage('node')->load($node->id());
    $this->assertTrue($node->isPublished());

    // Verify that the state field is not shown.
    $this->assertSession()->pageTextNotContains('Published');
    $this->drupalGet('node/' . $node->id() . '/delete');

    // Delete the node.
    $this->submitForm([], t('Delete'));
    $this->assertSession()->pageTextContains(t('The Moderated content moderated content has been deleted.'));
  }

  /**
   * Tests edit form destinations.
   */
  public function testFormSaveDestination() {
    $this->drupalGet('node/add/moderated_content');
    // Create new moderated content in draft.
    $this->submitForm([
      'title[0][value]' => 'Some moderated content',
      'body[0][value]' => 'First version of the content.',
    ], t('Save and Create New Draft'));

    $node = $this->drupalGetNodeByTitle('Some moderated content');
    $edit_path = sprintf('node/%d/edit', $node->id());

    // After saving, we should be at the canonical URL and viewing the first
    // revision.
    $this->assertSession()->addressEquals(Url::fromRoute('entity.node.canonical', ['node' => $node->id()]));
    $this->assertSession()->pageTextContains('First version of the content.');
    $this->drupalGet($edit_path);

    // Update the draft to review; after saving, we should still be on the
    // canonical URL, but viewing the second revision.
    $this->submitForm([
      'body[0][value]' => 'Second version of the content.',
    ], t('Save and Request Review'));
    $this->assertSession()->addressEquals(Url::fromRoute('entity.node.canonical', ['node' => $node->id()]));
    $this->assertSession()->pageTextContains('Second version of the content.');
    $this->drupalGet($edit_path);

    // Make a new published revision; after saving, we should be at the
    // canonical URL.
    $this->submitForm([
      'body[0][value]' => 'Third version of the content.',
    ], t('Save and Publish'));
    $this->assertSession()->addressEquals(Url::fromRoute('entity.node.canonical', ['node' => $node->id()]));
    $this->assertSession()->pageTextContains('Third version of the content.');
    $this->drupalGet($edit_path);

    // Make a new forward revision; after saving, we should be on the "Latest
    // version" tab.
    $this->submitForm([
      'body[0][value]' => 'Fourth version of the content.',
    ], t('Save and Create New Draft'));
    $this->assertSession()->addressEquals(Url::fromRoute('entity.node.latest_version', ['node' => $node->id()]));
    $this->assertSession()->pageTextContains('Fourth version of the content.');
  }

  /**
   * Tests pagers aren't broken by workbench_moderation.
   */
  public function testPagers() {
    // Create 51 nodes to force the pager.
    foreach (range(1, 51) as $delta) {
      Node::create([
        'type' => 'moderated_content',
        'uid' => $this->adminUser->id(),
        'title' => 'Node ' . $delta,
        'status' => 1,
        'moderation_state' => 'published',
      ])->save();
    }
    $this->drupalLogin($this->adminUser);
    $this->drupalGet('admin/content');
    $element = $this->cssSelect('nav.pager li.is-active a');
    $url = $element[0]->getAttribute('href');
    $query = [];
    parse_str(parse_url($url, PHP_URL_QUERY), $query);
    $this->assertEquals(0, $query['page']);
  }

}
