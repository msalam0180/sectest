<?php

namespace Drupal\sec_migration\Plugin\migrate\process;

/**
 * @file
 * Contains \Drupal\sec_migration\Plugin\migrate\process\GetTaxonomyTerm.
 */

use Drupal\migrate\MigrateExecutableInterface;
use Drupal\migrate\MigrateSkipRowException;
use Drupal\migrate\ProcessPluginBase;
use Drupal\migrate\Row;

/**
 * GetTaxonomyTerm returns the tid of a taxonomy term.
 * Differs from entity_lookup module which does not support parent terms.
 *
 * Example:
 *
 * field_test/target_id:
 *   plugin: get_taxonomy_term
 *   vocabulary: "cities"
 *   parent: "missouri"
 *   term: "springfield"
 *
 * The above example would return the tid of the springfield taxonomy term with a parent term named missouri.
 * If you had multiple terms named springfield, entity_lookup would not be able to differentiate between them.
 *
 *
 * @see \Drupal\migrate\Plugin\MigrateProcessInterface
 *
 * @MigrateProcessPlugin(
 *   id = "get_taxonomy_term"
 * )
 */
class GetTaxonomyTerm extends ProcessPluginBase {

  /**
   * {@inheritdoc}
   */
  public function transform($value, MigrateExecutableInterface $migrate_executable, Row $row, $destination_property) {
    if (empty($value)) {
      // Skip this item if there's no string value.
      throw new MigrateSkipRowException();
    }

    if (empty($this->configuration['vocabulary']) && !array_key_exists('vocabulary', $this->configuration)) {
      throw new MigrateException('get_taxonomy_term plugin is missing vocabulary configuration.');
    }

    $vocabulary = $this->configuration['vocabulary'];

    if (empty($vocabulary)) {
      // Skip this item if there's no string value.
      throw new MigrateSkipRowException();
    }

    if (empty($this->configuration['parent'])) {
      $query = \Drupal::entityQuery('taxonomy_term');
      $query->condition('vid', $vocabulary);
      $query->condition('name', $value);
      $tid = $query->execute();
      return $tid;
    } else {
      $parent = $this->configuration['parent'];
      $parentQuery = \Drupal::entityQuery('taxonomy_term');
      $parentQuery->condition('vid', $vocabulary);
      $parentQuery->condition('name', $parent);
      $parentId = $parentQuery->execute();

      if (!empty($parentId)) {
        $query = \Drupal::entityQuery('taxonomy_term');
        $query->condition('vid', $vocabulary);
        $query->condition('name', $value);
        $query->condition('parent.target_id', $parentId);
        $tid = $query->execute();

        return reset($tid);
      }
    }
    return null;
  }
}
