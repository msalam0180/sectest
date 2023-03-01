<?php

namespace Drupal\sec_migration\Plugin\migrate\process;

/**
 * @file
 * Contains \Drupal\sec_migration\Plugin\migrate\process\GetCommentsReceived.
 */

use Drupal\migrate\MigrateExecutableInterface;
use Drupal\migrate\MigrateSkipProcessException;
use Drupal\migrate\ProcessPluginBase;
use Drupal\migrate\Row;

/**
 * GetCommentsReceived returns the comments available notice from respondent string extracted from legacy AWS content listings
 *
 * @see \Drupal\migrate\Plugin\MigrateProcessInterface
 *
 * @MigrateProcessPlugin(
 *   id = "get_comments_received"
 * )
 */
class GetCommentsReceived extends ProcessPluginBase {

  /**
   * {@inheritdoc}
   */
  public function transform($value, MigrateExecutableInterface $migrate_executable, Row $row, $destination_property) {
    if (empty($value)) {
      // Skip this item if there's no string value.
      throw new MigrateSkipProcessException();
    }
    $regex = "/(?s)Comments.+?(?=Submit|$)/";
    preg_match($regex, $value, $matches);
    $links = [];
    if (!empty($matches[0])){
      $commentsNotice = $matches[0];

      if (stripos($commentsNotice," available (")){
        //reformat to be a url
        $regex = "/(?s)available \((.+)\)/";
        preg_match($regex, $commentsNotice, $urls);
        if (!empty($urls[1])) {
          $link = [];
          $link['title'] = "available";
          $link['uri'] = $urls[1];
          $link['options'] = [];
          array_push($links, $link);
        }
      }
      return $links;
    } else {
      //skip this field if no comments
      throw new MigrateSkipProcessException();
    }
  }
}
