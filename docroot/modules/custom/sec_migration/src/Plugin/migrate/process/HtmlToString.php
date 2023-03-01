<?php

namespace Drupal\sec_migration\Plugin\migrate\process;

/**
 * @file
 * Contains \Drupal\sec_migration\Plugin\migrate\process\HtmlToString.
 */

use Drupal\migrate\MigrateExecutableInterface;
use Drupal\migrate\MigrateSkipProcessException;
use Drupal\migrate\ProcessPluginBase;
use Drupal\migrate\Row;

/**
 * Retrieves a URL and returns it as an html string
 *
 * @MigrateProcessPlugin(
 *   id = "html_to_string"
 * )
 */
class HtmlToString extends ProcessPluginBase
{
    /**
       * {@inheritdoc}
       */
    public function transform($value, MigrateExecutableInterface $migrate_executable, Row $row, $destination_property)
    {

        if (empty($value)) {
            // Skip this item if there's no string value.
            throw new MigrateSkipProcessException();
        }
        $content = file($value);
        if (is_array($content)){
            return utf8_encode(implode('', $content));
        } else {
            return utf8_encode($content);
        }

    }
}

