<?php

namespace Drupal\workbench_moderation\Entity\Handler;

use Drupal\Core\Config\Entity\ConfigEntityInterface;
use Drupal\Core\Entity\ContentEntityInterface;
use Drupal\Core\Form\FormStateInterface;

/**
 * Defines operations that need to vary by entity type.
 *
 * Much of the logic contained in this handler is an indication of flaws
 * in the Entity API that are insufficiently standardized between entity types.
 * Hopefully over time functionality can be removed from this interface.
 */
interface ModerationHandlerInterface {

  /**
   * Work to be done before saving en entity.
   *
   * @param \Drupal\Core\Entity\ContentEntityInterface $entity
   *   The entity to modify.
   * @param bool $default_revision
   *   Whether the new revision should be made the default revision.
   * @param bool $published_state
   *   Whether the state being transitioned to is a published state or not.
   */
  public function onPresave(ContentEntityInterface $entity, $default_revision, $published_state);

  /**
   * Operates on the bundle definition that has been marked as moderatable.
   *
   * Note: The values on the EntityModerationForm itself are already saved
   * so do not need to be saved here. If any changes are made to the bundle
   * object here it is this method's responsibility to call save() on it.
   *
   * The most common use case is to force revisions on for this bundle if
   * moderation is enabled. That, sadly, does not have a common API in core.
   *
   * @param \Drupal\Core\Config\Entity\ConfigEntityInterface $bundle
   *   The bundle definition that is being saved.
   */
  public function onBundleModerationConfigurationFormSubmit(ConfigEntityInterface $bundle);

  /**
   * Alters entity forms to enforce revision handling.
   *
   * @param array $form
   *   An associative array containing the structure of the form.
   * @param \Drupal\Core\Form\FormStateInterface $form_state
   *   The current state of the form.
   * @param string $form_id
   *   The form id.
   *
   * @see hook_form_alter()
   */
  public function enforceRevisionsEntityFormAlter(array &$form, FormStateInterface $form_state, $form_id);

  /**
   * Alters bundle forms to enforce revision handling.
   *
   * @param array $form
   *   An associative array containing the structure of the form.
   * @param \Drupal\Core\Form\FormStateInterface $form_state
   *   The current state of the form.
   * @param string $form_id
   *   The form id.
   *
   * @see hook_form_alter()
   */
  public function enforceRevisionsBundleFormAlter(array &$form, FormStateInterface $form_state, $form_id);

}
