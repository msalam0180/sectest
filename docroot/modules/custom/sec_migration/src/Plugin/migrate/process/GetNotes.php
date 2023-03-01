<?php

namespace Drupal\sec_migration\Plugin\migrate\process;

/**
 * @file
 * Contains \Drupal\sec_migration\Plugin\migrate\process\GetNotes.
 */

use Drupal\migrate\MigrateExecutableInterface;
use Drupal\migrate\MigrateSkipRowException;
use Drupal\migrate\ProcessPluginBase;
use Drupal\migrate\Row;

/**
 * GetNotes returns the first Note: url and label from string
 *
 * @see \Drupal\migrate\Plugin\MigrateProcessInterface
 *
 * @MigrateProcessPlugin(
 *   id = "get_notes"
 * )
 */
class GetNotes extends ProcessPluginBase {

  /**
   * {@inheritdoc}
   */
  public function transform($value, MigrateExecutableInterface $migrate_executable, Row $row, $destination_property) {
    if (empty($value)) {
      // Skip this item if there's no string value.
      throw new MigrateSkipRowException();
    }
    $regex = "/\( Note:? (.*) \((http.[^)]+|public:.+[^$])\)/";
    preg_match($regex, $value, $matches);
    $returnArr = [];
    if (!empty($matches)) {
      $returnArr[0] = $matches[1];
      $returnArr[1] = $matches[2];

      if (strpos($returnArr[0], "(http") || strpos($returnArr[0], "(public://")) {
        $split = explode("(", $matches[1]);
        $returnArr[0] = $split[0];
        $returnArr[1] = explode(")", $split[1])[0];
      }
    }

    return $returnArr;
  }
}
