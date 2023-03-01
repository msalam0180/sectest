<?php

namespace Drupal\sec_legacy_migration\Plugin\migrate\process;

/**
 * @file
 * Contains \Drupal\sec_legacy_migration\Plugin\migrate\process\PublishDateImport.
 */

use Drupal\migrate\MigrateExecutableInterface;
use Drupal\migrate\MigrateSkipProcessException;
use Drupal\migrate\ProcessPluginBase;
use Drupal\migrate\Row;
use Drupal\node\Entity\Node;
use Drupal\Component\Utility\Html;
use Drupal\Core\Datetime\DrupalDateTime;
/**
 * Imports HTML Content and find the Title value
 *
 * @MigrateProcessPlugin(
 *   id = "publish_date_import"
 * )
 */
class PublishDateImport extends ProcessPluginBase
{
    /**
       * {@inheritdoc}
       */
    /**
    * {@inheritdoc}
    */
    public function transform($value, MigrateExecutableInterface $migrate_executable, Row $row, $destination_property) 
    {

        if (empty($value)) {
            // Skip this item if there's no string value.
            throw new MigrateSkipProcessException();
        }
        $dom = Html::load($value);
        $xpath = new \DOMXPath($dom);
        $regex = "/\d{1,2}\/\d{1,2}\/\d{4}/";
        $publishedDate = "";

        foreach ($xpath->query("//body/table[2]") as $node) {
            if ($node->hasChildNodes()) {
                foreach ($node->childNodes as $subnode) {
                    preg_match($regex, $subnode->textContent, $matches);
                    // $publishedDate = $row->getSourceProperty("url");
                    $publishedDate =  $matches[0];
                }
            }
        }
        if (empty($publishedDate)) {
            $publishedDate = $row->getSourceProperty("url");
        }
        var_dump($row->getSourceProperty("url"));
        var_dump($publishedDate);
    }
}
