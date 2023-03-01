<?php

namespace Drupal\sec_migration\Plugin\migrate\process;

/**
 * @file
 * Contains \Drupal\sec_migration\Plugin\migrate\process\GetModifiedDate.
 */

use Drupal\migrate\MigrateExecutableInterface;
use DateTime;
use Drupal\migrate\ProcessPluginBase;
use Drupal\migrate\Row;

/**
 * GetModifiedDate returns the modified date from a legacy html article body
 *
 * @see \Drupal\migrate\Plugin\MigrateProcessInterface
 *
 * @MigrateProcessPlugin(
 *   id = "get_modified_date"
 * )
 */
class GetModifiedDate extends ProcessPluginBase
{

    /**
   * {@inheritdoc}
   */
    public function transform($value, MigrateExecutableInterface $migrate_executable, Row $row, $destination_property)
    {
        if (!empty($value) && str_contains($value, "<h6>Modified")) {
            //split the html body into an array because modified dates are stored in h6 html element
            $bodyDate = explode("<h6>Modified: ", $value);
            if (is_array($bodyDate) && count($bodyDate) > 1) {
                //grab the date string in the html and then parse it into a valid date value
                $date = explode("</h6>", $bodyDate[1])[0];
                $dt = new DateTime();
                $dt->setTimestamp(strtotime($date));
                $dt->setTime(16, 00, 00);
                $modifiedDate = date_format($dt, 'Y-m-d\TH:i:s');
                return $modifiedDate;
            }
        }
    }
}
