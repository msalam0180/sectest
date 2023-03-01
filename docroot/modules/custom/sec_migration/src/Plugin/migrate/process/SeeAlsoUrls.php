<?php

namespace Drupal\sec_migration\Plugin\migrate\process;

/**
 * @file
 * Contains \Drupal\sec_migration\Plugin\migrate\process\SeeAlsoUrls.
 */

use Drupal\migrate\MigrateExecutableInterface;
use Drupal\migrate\MigrateSkipProcessException;
use Drupal\migrate\ProcessPluginBase;
use Drupal\migrate\Row;

/**
 * SeeAlsoUrls returns all See Also urls from string
 *
 * @see \Drupal\migrate\Plugin\MigrateProcessInterface
 *
 * @MigrateProcessPlugin(
 *   id = "see_also_urls"
 * )
 */
class SeeAlsoUrls extends ProcessPluginBase {

  /**
   * {@inheritdoc}
   */
  public function transform($value, MigrateExecutableInterface $migrate_executable, Row $row, $destination_property) {
    if (empty($value)) {
      // Skip this item if there's no string value.
      throw new MigrateSkipRowException();
    }
    $regex = "/(?s)\(((public|http).+?pdf|.+?txt|.+?htm)\)/i";
    preg_match_all($regex, $value, $matches);
    if (!empty($matches)) {
      return $matches[1];
    }

    return [];
  }
}
