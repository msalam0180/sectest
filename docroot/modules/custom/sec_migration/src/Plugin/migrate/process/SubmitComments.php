<?php

namespace Drupal\sec_migration\Plugin\migrate\process;

/**
 * @file
 * Contains \Drupal\sec_migration\Plugin\migrate\process\SubmitComments.
 */

use Drupal\migrate\MigrateExecutableInterface;
use Drupal\migrate\ProcessPluginBase;
use Drupal\migrate\Row;

/**
 * SubmitComments attempts to find a file number to reference
 *
 * @see \Drupal\migrate\Plugin\MigrateProcessInterface
 *
 * @MigrateProcessPlugin(
 *   id = "submit_comments"
 * )
 */
class SubmitComments extends ProcessPluginBase
{

    /**
   * {@inheritdoc}
   */
    public function transform($value, MigrateExecutableInterface $migrate_executable, Row $row, $destination_property)
    {
      if (empty($value)) {
        //we need to see if we can grab
        $respondents = $row->getSourceProperty('respondents');
        $fileNumber = explode(" Submit Comments on ", $respondents);
        if (strpos($fileNumber[1], "-") !== false) {
          return trim($fileNumber[1]);
        }
      }

      return $value;
    }

}
