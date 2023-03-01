<?php

namespace Drupal\sec_migration\Plugin\migrate\process;

/**
 * @file
 * Contains \Drupal\sec_migration\Plugin\migrate\process\GetRespondent.
 */

use Drupal\migrate\MigrateExecutableInterface;
use Drupal\migrate\MigrateSkipRowException;
use Drupal\migrate\ProcessPluginBase;
use Drupal\migrate\Row;

/**
 * GetRespondent returns the respondent from string extracted from legacy AWS content listings
 *
 * @see \Drupal\migrate\Plugin\MigrateProcessInterface
 *
 * @MigrateProcessPlugin(
 *   id = "get_respondent"
 * )
 */
class GetRespondent extends ProcessPluginBase {

  /**
   * {@inheritdoc}
   */
  public function transform($value, MigrateExecutableInterface $migrate_executable, Row $row, $destination_property) {
    if (empty($value)) {
      // Skip this item if there's no string value.
      throw new MigrateSkipRowException();
    }
    $regex = "/(?s)(.+?)(?=\( Note:|Note:|Release No|Other Release|See also|File No|PDF version|Court of Appeals|$)/i";
    preg_match($regex, $value, $matches);

    if (!empty($matches) && !empty($matches[1])) {
      $respondents = htmlspecialchars_decode(trim($matches[0]));
      //remove any trailing open parenthesis
      if (str_ends_with($respondents, "(")) {
        $respondents = substr($respondents, 0, -1);
      }
      return $respondents;
    } else {
      throw new MigrateSkipRowException();
    }
  }
}
