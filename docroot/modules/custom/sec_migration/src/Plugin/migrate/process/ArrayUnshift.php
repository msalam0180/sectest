<?php

namespace Drupal\sec_migration\Plugin\migrate\process;

/**
 * @file
 * Contains \Drupal\sec_migration\Plugin\migrate\process\ArrayUnshift.
 */

use Drupal\migrate\MigrateExecutableInterface;
use Drupal\migrate\ProcessPluginBase;
use Drupal\migrate\Row;

/**
 * Prepends the first source value to the beginning of the second source value, assuming the second source value is an array.
 *
 * @see \Drupal\migrate\Plugin\MigrateProcessInterface
 *
 * @MigrateProcessPlugin(
 *   id = "array_unshift"
 * )
 */
class ArrayUnshift extends ProcessPluginBase
{

    /**
   * {@inheritdoc}
   */
    public function transform($value, MigrateExecutableInterface $migrate_executable, Row $row, $destination_property)
    {
        if (is_array($value) && is_array($value[1])) {
            array_unshift($value[1], $value[0]);
            return $value[1];
        }
        return [];
    }

}
