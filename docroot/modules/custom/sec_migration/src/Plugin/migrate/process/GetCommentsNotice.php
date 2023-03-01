<?php

namespace Drupal\sec_migration\Plugin\migrate\process;

/**
 * @file
 * Contains \Drupal\sec_migration\Plugin\migrate\process\GetCommentsNotice.
 */

use Drupal\migrate\MigrateExecutableInterface;
use Drupal\migrate\MigrateSkipProcessException;
use Drupal\migrate\ProcessPluginBase;
use Drupal\migrate\Row;

/**
 * GetCommentsNotice returns the comments due/comments available notice from respondent string extracted from legacy AWS content listings
 *
 * @see \Drupal\migrate\Plugin\MigrateProcessInterface
 *
 * @MigrateProcessPlugin(
 *   id = "get_comments_notice"
 * )
 */
class GetCommentsNotice extends ProcessPluginBase {

  /**
   * {@inheritdoc}
   */
  public function transform($value, MigrateExecutableInterface $migrate_executable, Row $row, $destination_property) {
    if (empty($value)) {
      // Skip this item if there's no string value.
      throw new MigrateSkipProcessException();
    }
    $regex = "/(?s)Comments due:? (.+?)(?=Comments received|$|Submit|See also)/";
    preg_match($regex, $value, $matches);

    if (!empty($matches) && !empty($matches[1])){
      $commentsNotice = $matches[1];
      return trim($commentsNotice);
    } else {
      //skip this field if no comments
      throw new MigrateSkipProcessException();
    }
  }
}
