<?php

namespace Drupal\Tests\workbench_moderation\Kernel;

use Drupal\KernelTests\KernelTestBase;
use Drupal\language\Entity\ConfigurableLanguage;
use Drupal\node\Entity\Node;
use Drupal\node\Entity\NodeType;
use Drupal\Tests\user\Traits\UserCreationTrait;

/**
 * @coversDefaultClass \Drupal\workbench_moderation\Plugin\Validation\Constraint\ModerationStateValidator
 * @group workbench_moderation
 */
class EntityStateChangeValidationTest extends KernelTestBase {

  use UserCreationTrait;

  /**
   * {@inheritdoc}
   */
  protected static $modules = [
    'node',
    'workbench_moderation',
    'user',
    'system',
    'language',
    'content_translation',
  ];

  /**
   * An admin user account.
   *
   * @var \Drupal\Core\Session\AccountInterface
   */
  protected $adminUser;

  /**
   * {@inheritdoc}
   */
  protected function setUp(): void {
    parent::setUp();

    $this->installSchema('node', 'node_access');
    $this->installSchema('system', ['sequences']);
    $this->installEntitySchema('node');
    $this->installEntitySchema('user');
    $this->installConfig('workbench_moderation');

    $this->adminUser = $this->createUser(array_keys($this->container->get('user.permissions')->getPermissions()));
  }

  /**
   * Test valid transitions.
   *
   * @covers ::validate
   */
  public function testValidTransition() {
    $this->setCurrentUser($this->adminUser);

    $node_type = NodeType::create([
      'type' => 'example',
    ]);
    $node_type->save();
    $node = Node::create([
      'type' => 'example',
      'title' => 'Test title',
      'moderation_state' => 'draft',
    ]);
    $node->save();

    $node->moderation_state->target_id = 'needs_review';
    $this->assertCount(0, $node->validate());
  }

  /**
   * Test invalid transitions.
   *
   * @covers ::validate
   */
  public function testInvalidTransition() {
    $this->setCurrentUser($this->adminUser);

    $node_type = NodeType::create([
      'type' => 'example',
    ]);
    $node_type->setThirdPartySetting('workbench_moderation', 'enabled', TRUE);
    $node_type->save();
    $node = Node::create([
      'type' => 'example',
      'title' => 'Test title',
      'moderation_state' => 'draft',
    ]);
    $node->save();

    $node->moderation_state->target_id = 'archived';
    $violations = $node->validate();
    $this->assertCount(1, $violations);

    $this->assertEquals('Invalid state transition from <em class="placeholder">Draft</em> to <em class="placeholder">Archived</em>', $violations->get(0)->getMessage());
  }

  /**
   * Verifies if content without prior moderation information can be moderated.
   */
  public function testContent() {
    $this->setCurrentUser($this->adminUser);

    $node_type = NodeType::create([
      'type' => 'example',
    ]);
    $node_type->save();
    /** @var \Drupal\node\Entity\NodeInterface $node */
    $node = Node::create([
      'type' => 'example',
      'title' => 'Test title',
    ]);
    $node->save();

    $nid = $node->id();

    // Enable moderation for our node type.
    /** @var \Drupal\node\Entity\NodeType $node_type */
    $node_type = NodeType::load('example');
    $node_type->setThirdPartySetting('workbench_moderation', 'enabled', TRUE);
    $node_type->setThirdPartySetting('workbench_moderation', 'allowed_moderation_states',
    ['draft', 'needs_review', 'published']);
    $node_type->setThirdPartySetting('workbench_moderation', 'default_moderation_state', 'draft');
    $node_type->save();

    $node = Node::load($nid);

    // Having no previous state should not break validation.
    $violations = $node->validate();

    $this->assertCount(0, $violations);

    // Having no previous state should not break saving the node.
    $node->setTitle('New');
    $node->save();
  }

  /**
   * Verifies content without prior moderation information can be translated.
   */
  public function testMultilingualContent() {
    // Enable French.
    ConfigurableLanguage::createFromLangcode('fr')->save();

    $node_type = NodeType::create([
      'type' => 'example',
    ]);
    $node_type->save();
    /** @var \Drupal\node\Entity\NodeInterface $node */
    $node = Node::create([
      'type' => 'example',
      'title' => 'Test title',
      'langcode' => 'en',
    ]);
    $node->save();

    $nid = $node->id();

    $node = Node::load($nid);

    // Creating a translation shouldn't break, even though there's no previous
    // moderated revision for the new language.
    $node_fr = $node->addTranslation('fr');
    $node_fr->setTitle('Francais');
    $node_fr->save();

    // Enable moderation for our node type.
    /** @var \Drupal\node\Entity\NodeType $node_type */
    $node_type = NodeType::load('example');
    $node_type->setThirdPartySetting('workbench_moderation', 'enabled', TRUE);
    $node_type->setThirdPartySetting('workbench_moderation', 'allowed_moderation_states',
    ['draft', 'needs_review', 'published']);
    $node_type->setThirdPartySetting('workbench_moderation', 'default_moderation_state', 'draft');
    $node_type->save();

    // Reload the French version of the node.
    $node = Node::load($nid);
    $node_fr = $node->getTranslation('fr');

    /** @var \Drupal\node\Entity\NodeInterface $node_fr */
    $node_fr->setTitle('Nouveau');
    $node_fr->save();
  }

  /**
   * Test transistion access validation on new entity creation.
   *
   * @dataProvider transitionAccessValidationTestCases
   */
  public function testTransitionAccessValidationNewEntity($permissions, $default_state, $target_state, $messages) {
    $this->setCurrentUser($this->createUser($permissions));
    $this->createExampleModeratedContentType($default_state,
    ['draft', 'needs_review', 'published', 'archived']);

    $node = Node::create([
      'type' => 'example',
      'title' => 'Test content',
      'moderation_state' => $target_state,
    ]);
    $this->assertTrue($node->isNew());

    $violations = $node->validate();
    $this->assertCount(count($messages), $violations);
    foreach ($messages as $i => $message) {
      $this->assertEquals($message, $violations->get($i)->getMessage());
    }
  }

  /**
   * Test transition access validation on entity save.
   *
   * @dataProvider transitionAccessValidationTestCases
   */
  public function testTransitionAccessValidationSavedEntity($permissions, $default_state, $target_state, $messages) {
    $this->setCurrentUser($this->createUser($permissions));
    $this->createExampleModeratedContentType($default_state,
    ['draft', 'needs_review', 'published', 'archived']);

    $node = Node::create([
      'type' => 'example',
      'title' => 'Test content',
      'moderation_state' => $default_state,
    ]);
    $node->save();

    $node->moderation_state = $target_state;

    $violations = $node->validate();
    $this->assertCount(count($messages), $violations);
    foreach ($messages as $i => $message) {
      $this->assertEquals($message, $violations->get($i)->getMessage());
    }
  }

  /**
   * Test cases for access validation.
   */
  public function transitionAccessValidationTestCases() {
    return [
      'Invalid transition, no permissions validated' => [
        [],
        'draft',
        'archived',
        ['Invalid state transition from <em class="placeholder">Draft</em> to <em class="placeholder">Archived</em>'],
      ],
      'Valid transition, missing permission' => [
        [],
        'draft',
        'published',
        ['You do not have access to transition from <em class="placeholder">Draft</em> to <em class="placeholder">Published</em>'],
      ],
      'Valid transition, granted published permission' => [
        ['use draft_published transition'],
        'draft',
        'published',
        [],
      ],
      'Valid transition, granted draft permission' => [
        ['use draft_draft transition'],
        'draft',
        'draft',
        [],
      ],
      'Valid transition, incorrect permission granted' => [
        ['use draft_draft transition'],
        'draft',
        'published',
        ['You do not have access to transition from <em class="placeholder">Draft</em> to <em class="placeholder">Published</em>'],
      ],
      'Non-draft default state, incorrect permission granted' => [
        ['use draft_draft transition'],
        'archived',
        'published',
        ['You do not have access to transition from <em class="placeholder">Archived</em> to <em class="placeholder">Published</em>'],
      ],
      'Non-draft default state, correct permission granted' => [
        ['use archived_published transition'],
        'archived',
        'published',
        [],
      ],
      'Non-draft default state, invalid transition' => [
        ['use published_archived transition'],
        'archived',
        'draft',
        ['Invalid state transition from <em class="placeholder">Archived</em> to <em class="placeholder">Draft</em>'],
      ],
    ];
  }

  /**
   * Create an example content type.
   *
   * @param string $default_state
   *   The default state.
   * @param array $allowed_states
   *   The allowed states.
   */
  protected function createExampleModeratedContentType($default_state, array $allowed_states) {
    $node_type = NodeType::create([
      'type' => 'example',
    ]);
    $node_type->save();

    $node_type = NodeType::load('example');
    $node_type->setThirdPartySetting('workbench_moderation', 'enabled', TRUE);
    $node_type->setThirdPartySetting('workbench_moderation', 'allowed_moderation_states', $allowed_states);
    $node_type->setThirdPartySetting('workbench_moderation', 'default_moderation_state', $default_state);
    $node_type->save();
  }

}
