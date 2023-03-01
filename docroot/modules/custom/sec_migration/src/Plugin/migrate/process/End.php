<?php

namespace Drupal\sec_migration\Plugin\migrate\process;

/**
 * @file
 * Contains \Drupal\sec_migration\Plugin\migrate\process\End.
 */

use Drupal\migrate\MigrateExecutableInterface;
use Drupal\migrate\MigrateSkipProcessException;
use Drupal\migrate\ProcessPluginBase;
use Drupal\migrate\Row;

/**
 * End returns the last element from a string or array
 *
 * @see \Drupal\migrate\Plugin\MigrateProcessInterface
 *
 * @MigrateProcessPlugin(
 *   id = "end"
 * )
 */
class End extends ProcessPluginBase
{

    /**
   * {@inheritdoc}
   */
    public function transform($value, MigrateExecutableInterface $migrate_executable, Row $row, $destination_property) 
    {

        if (is_array($value)) {
            return end($value);
        } else {
            $hasDelimiter = !empty($this->configuration['delimiter']) ?: false;
            if ($hasDelimiter){
                $arr = explode($this->configuration['delimiter'], $value);
                return end($arr);
            }
        }
        return [];
    }

}
