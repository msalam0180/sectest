<?php

namespace Drupal\workbench_moderation\ParamConverter;

use Drupal\Core\Entity\EntityInterface;
use Drupal\Core\Entity\EntityRepositoryInterface;
use Drupal\Core\ParamConverter\EntityConverter;
use Drupal\Core\TypedData\TranslatableInterface;
use Drupal\workbench_moderation\ModerationInformationInterface;
use Symfony\Component\Routing\Route;
use Drupal\Core\Entity\EntityTypeManagerInterface;

/**
 * Defines a class for making sure the edit-route loads the current draft.
 */
class EntityRevisionConverter extends EntityConverter {

  /**
   * Moderation information.
   *
   * @var \Drupal\workbench_moderation\ModerationInformationInterface
   */
  protected $moderationInformation;

  /**
   * EntityRevisionConverter constructor.
   *
   * @param \Drupal\Core\Entity\EntityTypeManagerInterface $entity_type_manager
   *   The entity manager, needed by the parent class.
   * @param \Drupal\workbench_moderation\ModerationInformationInterface $moderation_info
   *   The moderation info utility service.
   * @param \Drupal\Core\Entity\EntityRepositoryInterface $entity_repository
   *   Entity repository.
   */
  public function __construct(EntityTypeManagerInterface $entity_type_manager, ModerationInformationInterface $moderation_info, EntityRepositoryInterface $entity_repository) {
    parent::__construct($entity_type_manager, $entity_repository);
    $this->moderationInformation = $moderation_info;
  }

  /**
   * {@inheritdoc}
   */
  public function applies($definition, $name, Route $route) {
    return $this->hasForwardRevisionFlag($definition) || $this->isEditFormPage($route);
  }

  /**
   * Determines if the route definition includes a forward-revision flag.
   *
   * This is a custom flag defined by WBM to load forward revisions rather than
   * the default revision on a given route.
   *
   * @param array $definition
   *   The parameter definition provided in the route options.
   *
   * @return bool
   *   TRUE if the forward revision flag is set, FALSE otherwise.
   */
  protected function hasForwardRevisionFlag(array $definition) {
    return (isset($definition['load_forward_revision']) && $definition['load_forward_revision']);
  }

  /**
   * Determines if a given route is the edit-form for an entity.
   *
   * @param \Symfony\Component\Routing\Route $route
   *   The route definition.
   *
   * @return bool
   *   Returns TRUE if the route is the edit form of an entity, FALSE otherwise.
   */
  protected function isEditFormPage(Route $route) {
    if ($default = $route->getDefault('_entity_form')) {
      // If no operation is provided, use 'default'.
      $default .= '.default';
      [$entity_type_id, $operation] = explode('.', $default);
      if (!$this->entityTypeManager->hasDefinition($entity_type_id)) {
        return FALSE;
      }
      $entity_type = $this->entityTypeManager->getDefinition($entity_type_id);
      return $operation == 'edit' && $entity_type && $entity_type->isRevisionable();
    }
  }

  /**
   * {@inheritdoc}
   */
  public function convert($value, $definition, $name, array $defaults) {
    $entity = parent::convert($value, $definition, $name, $defaults);

    if ($entity && $this->moderationInformation->isModeratableEntity($entity) && !$this->moderationInformation->isLatestRevision($entity)) {
      $entity_type_id = $this->getEntityTypeFromDefaults($definition, $name, $defaults);
      $entity = $this->moderationInformation->getLatestRevision($entity_type_id, $value);

      // If the entity type is translatable, ensure we return the proper
      // translation object for the current context.
      if ($entity instanceof EntityInterface && $entity instanceof TranslatableInterface) {
        $entity = $this->entityRepository->getTranslationFromContext($entity, NULL, ['operation' => 'entity_upcast']);
      }
    }

    return $entity;
  }

}
