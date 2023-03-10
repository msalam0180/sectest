<?php

namespace Drupal\workbench_moderation;

use Drupal\Core\Config\Entity\DraggableListBuilder;
use Drupal\Core\Entity\EntityInterface;
use Drupal\Core\Entity\EntityStorageInterface;
use Drupal\Core\Entity\EntityTypeInterface;
use Symfony\Component\DependencyInjection\ContainerInterface;

/**
 * Provides a listing of Moderation state transition entities.
 */
class ModerationStateTransitionListBuilder extends DraggableListBuilder {

  /**
   * Entity state storage.
   *
   * @var \Drupal\Core\Entity\EntityStorageInterface
   */
  protected $stateStorage;

  /**
   * {@inheritdoc}
   */
  public static function createInstance(ContainerInterface $container, EntityTypeInterface $entity_type) {
    return new static(
      $entity_type,
      $container->get('entity_type.manager')->getStorage($entity_type->id()),
      $container->get('entity_type.manager')->getStorage('moderation_state')
    );
  }

  /**
   * Constructs a new ModerationStateTransitionListBuilder.
   *
   * @param \Drupal\Core\Entity\EntityTypeInterface $entity_type
   *   The entity type service.
   * @param \Drupal\Core\Entity\EntityStorageInterface $transition_storage
   *   Entity transition storage.
   * @param \Drupal\Core\Entity\EntityStorageInterface $state_storage
   *   Entity state storage.
   */
  public function __construct(EntityTypeInterface $entity_type, EntityStorageInterface $transition_storage, EntityStorageInterface $state_storage) {
    parent::__construct($entity_type, $transition_storage);
    $this->stateStorage = $state_storage;
  }

  /**
   * {@inheritdoc}
   */
  public function getFormId() {
    return 'workbench_moderation_transition_list';
  }

  /**
   * {@inheritdoc}
   */
  public function buildHeader() {
    $header['label'] = $this->t('Moderation state transition');
    $header['id'] = $this->t('Machine name');
    $header['from'] = $this->t('From state');
    $header['to'] = $this->t('To state');
    return $header + parent::buildHeader();
  }

  /**
   * {@inheritdoc}
   */
  public function buildRow(EntityInterface $entity) {
    /** @var ModerationStateTransitionInterface $entity */

    $row['label'] = $entity->label();
    $row['id']['#markup'] = $entity->id();
    $row['from']['#markup'] = $this->stateStorage->load($entity->getFromState())->label();
    $row['to']['#markup'] = $this->stateStorage->load($entity->getToState())->label();

    return $row + parent::buildRow($entity);
  }

  /**
   * {@inheritdoc}
   */
  public function render() {
    $build = parent::render();

    $build['item'] = [
      '#type' => 'item',
      '#markup' => $this->t('When saving an entity, only a destination state that has a transition is legal. That includes its current state. If you want to allow an entity to be saved without changing its state then you must define a transition from that state to itself. Note that all users will still need permission to use a defined transition.'),
      '#weight' => -5,
    ];

    return $build;
  }

}
