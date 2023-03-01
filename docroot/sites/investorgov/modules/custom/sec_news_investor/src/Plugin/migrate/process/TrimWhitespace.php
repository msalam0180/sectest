<?php

namespace Drupal\sec_news_investor\Plugin\migrate\process;

use Drupal\migrate\MigrateException;
use Drupal\migrate\MigrateExecutableInterface;
use Drupal\migrate\ProcessPluginBase;
use Drupal\migrate\Row;


/**
* Remove leading and trailing whitespace.
*
* @MigrateProcessPlugin(
*   id = "trim_whitespace"
* )
*
* @code
* field_text:
*   plugin: trim_whitespace
*   source: text
* @endcode
*
*/
class TrimWhitespace extends ProcessPluginBase {
  /**
  * {@inheritdoc}
  */
  public function transform($value, MigrateExecutableInterface $migrate_executable, Row $row, $destination_property) {
    // Trim the leading and trailing whitespace
    return trim($value);
  }
}
