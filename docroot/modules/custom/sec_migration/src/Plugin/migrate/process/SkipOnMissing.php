<?php

namespace Drupal\sec_migration\Plugin\migrate\process;

use Drupal\migrate\MigrateException;
use Drupal\migrate\MigrateExecutableInterface;
use Drupal\migrate\MigrateSkipProcessException;
use Drupal\migrate\MigrateSkipRowException;
use Drupal\migrate\ProcessPluginBase;
use Drupal\migrate\Row;

/**
 * If the source does not contain a value, skip processing or whole row.
 *
 * @MigrateProcessPlugin(
 *   id = "skip_on_missing"
 * )
 */
class SkipOnMissing extends ProcessPluginBase
{

    /**
   * {@inheritdoc}
   */
    public function row($value, MigrateExecutableInterface $migrate_executable, Row $row, $destination_property)
    {
        if (empty($this->configuration['missing']) && !array_key_exists('missing', $this->configuration)) {
            throw new MigrateException('skip_on_missing plugin is missing configuration.');
        }

        if (is_array($this->configuration['missing'])) {
            $count = 0;
            foreach ($this->configuration['missing'] as $skipValue) {
                if (stripos($value, $skipValue) == false) {
                    $count = $count + 1;
                }
            }
            if ($count == count($this->configuration['missing'])) {
                throw new MigrateSkipRowException();
            }
        } elseif (stripos($value, $this->configuration['missing']) == false) {
            throw new MigrateSkipRowException();
        }
        return $value;
    }

    /**
   * {@inheritdoc}
   */
    public function process($value, MigrateExecutableInterface $migrate_executable, Row $row, $destination_property)
    {
        if (empty($this->configuration['missing']) && !array_key_exists('missing', $this->configuration)) {
            throw new MigrateException('skip_on_missing plugin is missing configuration.');
        }

        if (is_array($this->configuration['missing'])) {
            $count = 0;
            foreach ($this->configuration['missing'] as $skipValue) {
                if (stripos($value, $skipValue) == false) {
                    $count = $count + 1;
                }
            }
            if ($count == count($this->configuration['missing'])) {
                throw new MigrateSkipProcessException();
            }
        } elseif (stripos($value, $this->configuration['missing']) == false) {
            throw new MigrateSkipProcessException();
        }

        return $value;
    }


}
