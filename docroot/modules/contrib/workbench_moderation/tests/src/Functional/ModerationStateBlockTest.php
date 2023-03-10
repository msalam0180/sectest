<?php

namespace Drupal\Tests\workbench_moderation\Functional;

use Drupal\block_content\Entity\BlockContent;
use Drupal\block_content\Entity\BlockContentType;

/**
 * Tests general content moderation workflow for blocks.
 *
 * @group workbench_moderation
 */
class ModerationStateBlockTest extends ModerationStateTestBase {

  /**
   * {@inheritdoc}
   */
  protected function setUp(): void {
    parent::setUp();

    // Create the "basic" block type.
    $bundle = BlockContentType::create([
      'id' => 'basic',
      'label' => 'basic',
      'revision' => FALSE,
    ]);
    $bundle->save();

    // Add the body field to it.
    block_content_add_body_field($bundle->id());
  }

  /**
   * Tests moderating custom blocks.
   *
   * Blocks and any non-node-type-entities do not have a concept of
   * "published". As such, we must use the "default revision" to know what is
   * going to be "published", i.e. visible to the user.
   *
   * The one exception is a block that has never been "published". When a block
   * is first created, it becomes the "default revision". For each edit of the
   * block after that, Workbench Moderation checks the "default revision" to
   * see if it is set to a published moderation state. If it is not, the entity
   * being saved will become the "default revision".
   *
   * The test below is intended, in part, to make this behavior clear.
   *
   * @see \Drupal\workbench_moderation\EntityOperations::entityPresave
   * @see \Drupal\Tests\workbench_moderation\Functional\ModerationFormTest::testModerationForm
   */
  public function testCustomBlockModeration() {
    $this->drupalLogin($this->rootUser);

    // Enable moderation for custom blocks at
    // admin/structure/block/block-content/manage/basic/moderation.
    $edit = [
      'enable_moderation_state' => TRUE,
      'allowed_moderation_states_unpublished[draft]' => TRUE,
      'allowed_moderation_states_published[published]' => TRUE,
      'default_moderation_state' => 'draft',
    ];
    $this->drupalGet('admin/structure/block/block-content/manage/basic/moderation');
    $this->submitForm($edit, t('Save'));
    $this->assertSession()->pageTextContains(t('Your settings have been saved.'));

    // Create a custom block at block/add and save it as draft.
    $body = 'Body of moderated block';
    $edit = [
      'info[0][value]' => 'Moderated block',
      'body[0][value]' => $body,
    ];
    $this->drupalGet('block/add');
    $this->submitForm($edit, t('Save and Create New Draft'));
    $this->assertSession()->pageTextContains(t('basic Moderated block has been created.'));

    // Place the block in the Sidebar First region.
    $instance = [
      'id' => 'moderated_block',
      'settings[label]' => $edit['info[0][value]'],
      'region' => 'sidebar_first',
    ];
    $block = BlockContent::load(1);
    $url = 'admin/structure/block/add/block_content:' . $block->uuid() . '/' . $this->config('system.theme')->get('default');
    $this->drupalGet($url);
    $this->submitForm($instance, t('Save block'));

    // Navigate to home page and check that the block is visible. It should be
    // visible because it is the default revision.
    $this->drupalGet('');
    $this->assertSession()->pageTextContains($body);

    // Update the block.
    $updated_body = 'This is the new body value';
    $edit = [
      'body[0][value]' => $updated_body,
    ];
    $this->drupalGet('block/' . $block->id());
    $this->submitForm($edit, t('Save and Create New Draft'));
    $this->assertSession()->pageTextContains(t('basic Moderated block has been updated.'));

    // Navigate to the home page and check that the block shows the updated
    // content. It should show the updated content because the block's default
    // revision is not a published moderation state.
    $this->drupalGet('');
    $this->assertSession()->pageTextContains($updated_body);
    $this->drupalGet('block/' . $block->id());

    // Publish the block so we can create a forward revision.
    $this->submitForm([], t('Save and Publish'));

    // Create a forward revision.
    $forward_revision_body = 'This is the forward revision body value';
    $edit = [
      'body[0][value]' => $forward_revision_body,
    ];
    $this->drupalGet('block/' . $block->id());
    $this->submitForm($edit, t('Save and Create New Draft'));
    $this->assertSession()->pageTextContains(t('basic Moderated block has been updated.'));

    // Navigate to home page and check that the forward revision doesn't show,
    // since it should not be set as the default revision.
    $this->drupalGet('');
    $this->assertSession()->pageTextContains($updated_body);

    // Open the latest tab and publish the new draft.
    $edit = [
      'new_state' => 'published',
    ];
    $this->drupalGet('block/' . $block->id() . '/latest');
    $this->submitForm($edit, t('Apply'));
    $this->assertSession()->pageTextContains(t('The moderation state has been updated.'));

    // Navigate to home page and check that the forward revision is now the
    // default revision and therefore visible.
    $this->drupalGet('');
    $this->assertSession()->pageTextContains($forward_revision_body);
  }

}
