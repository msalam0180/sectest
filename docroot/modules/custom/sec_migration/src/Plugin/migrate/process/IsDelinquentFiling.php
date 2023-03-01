<?php

namespace Drupal\sec_migration\Plugin\migrate\process;

/**
 * @file
 * Contains \Drupal\sec_migration\Plugin\migrate\process\IsDelinquentFiling.
 */

use Drupal\migrate\MigrateExecutableInterface;
use Drupal\migrate\MigrateSkipProcessException;
use Drupal\migrate\ProcessPluginBase;
use Drupal\migrate\Row;

/**
 * IsDelinquentFiling returns a boolean if this release a delinquent filing
 *
 * @see \Drupal\migrate\Plugin\MigrateProcessInterface
 *
 * @MigrateProcessPlugin(
 *   id = "is_delinquent"
 * )
 */
class IsDelinquentFiling extends ProcessPluginBase
{

    /**
   * {@inheritdoc}
   */
    public function transform($value, MigrateExecutableInterface $migrate_executable, Row $row, $destination_property)
    {
        if (empty($value)) {
            throw new MigrateSkipProcessException();
        }

        $delinquent = \Drupal::database()->query('SELECT id FROM {delinquent_filings} WHERE id = :id', [':id' => $value])->fetchField();
        return !empty($delinquent);
    }

}
