<?php

namespace Drupal\sec_migration\Plugin\migrate\process;

/**
 * @file
 * Contains \Drupal\sec_migration\Plugin\migrate\process\GetOtherReleaseNos.
 */

use Drupal\migrate\MigrateExecutableInterface;
use Drupal\migrate\MigrateSkipProcessException;
use Drupal\migrate\ProcessPluginBase;
use Drupal\migrate\Row;

/**
 * GetOtherReleaseNos returns the other release numbers from respondent string extracted from legacy AWS content listings
 *
 * @see \Drupal\migrate\Plugin\MigrateProcessInterface
 *
 * @MigrateProcessPlugin(
 *   id = "get_other_release_nos"
 * )
 */
class GetOtherReleaseNos extends ProcessPluginBase {

  /**
   * {@inheritdoc}
   */
  public function transform($value, MigrateExecutableInterface $migrate_executable, Row $row, $destination_property) {
    if (empty($value)) {
      // Skip this item if there's no string value.
      throw new MigrateSkipProcessException();
    }
    $regex = "/(?s)(Other Release Nos\.:?|Release No\.:?|Release Nos\.:?|Other Release No\.:?) (.+?) ?(?=Note|See|;|$)/i";
    preg_match($regex, $value, $matches);
    $returnArr = [];
    $id = $row->getSourceProperty("id");
    $returnArr[] = $id;

    if (!empty($matches) && !empty($matches[2])){
      if (strpos($matches[2], ";")) {
        $returnArr = array_merge($returnArr, explode(";", $matches[2]));
      } else {
        $returnArr = array_merge($returnArr, explode(",", $matches[2]));
      }
    }

    //check if theres an AAER for this ID
    $aaer = \Drupal::database()->query('SELECT id FROM {aaer} WHERE respondents like :id', [':id' => "%$id%"])->fetchField();
    if (!empty($aaer)) {
      array_push($returnArr, $aaer);
    }

    $returnArr = array_map('trim',$returnArr);
    $returnArr = array_unique($returnArr);
    return $returnArr;
  }
}
