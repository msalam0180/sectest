<?php

namespace Drupal\sec_migration\Plugin\migrate\process;

/**
 * @file
 * Contains \Drupal\sec_migration\Plugin\migrate\process\GetFilePath.
 */

use Drupal\migrate\MigrateExecutableInterface;
use Drupal\migrate\MigrateSkipRowException;
use Drupal\migrate\ProcessPluginBase;
use Drupal\migrate\Row;

/**
 * GetFilePath returns the tid of a taxonomy term given a url of an imported file
 *
 * Example:
 *
 * field_test/target_id:
 *   plugin: get_file_path
 *   vocabulary: "file_path"
 *   source: "https://www.sec.gov/litigation/admin/2019/1234.pdf"
 *
 * The above example would return the tid of the litigation/admin/2019 taxonomy term.
 *
 * @see \Drupal\migrate\Plugin\MigrateProcessInterface
 *
 * @MigrateProcessPlugin(
 *   id = "get_file_path"
 * )
 */
class GetFilePath extends ProcessPluginBase {

  /**
   * {@inheritdoc}
   */
  public function transform($value, MigrateExecutableInterface $migrate_executable, Row $row, $destination_property) {
    if (empty($value)) {
      // Skip this item if there's no string value.
      throw new MigrateSkipRowException();
    }

    if (empty($this->configuration['vocabulary']) && !array_key_exists('vocabulary', $this->configuration)) {
      throw new MigrateException('get_file_path plugin is missing vocabulary configuration.');
    }

    $baseUrl = "sec.gov/";
    if (str_contains($value, "public://release_importer/")) {
      $baseUrl = "public://release_importer/";
    } else if (str_contains($value, "public://")) {
      $baseUrl = "public://";
    }

    $vocabulary = $this->configuration['vocabulary'];
    $urlpath = explode($baseUrl,$value)[1];

    if (!empty($urlpath)) {
      $dirs = explode("/", $urlpath);
      $parentId = "";
      for ($x = 0; $x < count($dirs) - 1; $x++) {
        $dir = $dirs[$x];
        $query = \Drupal::entityQuery('taxonomy_term');
        $query->condition('vid', $vocabulary);
        $query->condition('name', $dir);
        if (!empty($parentId)) {
          $query->condition('parent.target_id', $parentId);
        }
        $parentId = reset($query->execute());
      }
      return $parentId;
    }

    return null;
  }
}
