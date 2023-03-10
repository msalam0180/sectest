<?php

namespace Drupal\workbench_moderation;

/**
 * Tracks metadata about revisions across content entities.
 */
interface RevisionTrackerInterface {

  /**
   * Sets the latest revision of a given entity.
   *
   * @param string $entity_type
   *   The machine name of the type of entity.
   * @param string $entity_id
   *   The Entity ID in question.
   * @param string $langcode
   *   The langcode of the revision we're saving. Each language has its own
   *   effective tree of entity revisions, so in different languages
   *   different revisions will be "latest".
   * @param string $revision_id
   *   The revision ID that is now the latest revision.
   *
   * @return static
   */
  public function setLatestRevision($entity_type, $entity_id, $langcode, $revision_id);

}
