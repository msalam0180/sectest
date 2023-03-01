<?php

namespace Drupal\sec_legacy_migration\Plugin\migrate\process;

/**
 * @file
 * Contains \Drupal\sec_legacy_migration\Plugin\migrate\process\ModifiedDateImport.
 */
use Drupal\migrate\MigrateExecutableInterface;
use Drupal\migrate\MigrateSkipProcessException;
use Drupal\migrate\ProcessPluginBase;
use Drupal\migrate\Row;
use Drupal\node\Entity\Node;
use Drupal\Component\Utility\Html;
use Drupal\Core\Datetime\DrupalDateTime;
use DateTimeZone;
use DateInterval;

/**
 * Imports HTML Content and find the Title value
 *
 * @MigrateProcessPlugin(
 * id = "modified_date_import"
 * )
 */
class ModifiedDateImport extends ProcessPluginBase
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
        $regex = "/([!A-Z][a-z]+: *)/";
        $modifiedDate = "";
    
        foreach ( $xpath->query("//h6") as $node ) {
            if ($node->hasChildNodes()) {
                foreach ( $node->childNodes as $subnode ) {
                    $modifiedDate = $subnode->textContent;
                }
            }
        }
    
        if (empty($modifiedDate)) {
            foreach ( $xpath->query("//*[@id='ssi-modified']") as $node ) {
                if ($node->hasChildNodes()) {
                    foreach ( $node->childNodes as $subnode ) {
                        $modifiedDate = $subnode->textContent;
                    }
                }
            }
        }
    
        if (empty($modifiedDate)) {
            foreach ( $xpath->query("//*[@id=\"block-secgov-content\"]/article/div[2]") as $node ) {
                if ($node->hasChildNodes()) {
                    foreach ( $node->childNodes as $subnode ) {
                        $modifiedDate = $subnode->textContent;
                    }
                }
            }
        }
    
        if (empty($modifiedDate)) {
            $modifiedDate = $row->getSourceProperty("url");
      
        }
    
        try {
            $extractedDate = trim(preg_replace($regex, '', $modifiedDate));
            $date = new DrupalDateTime($extractedDate);
            $date = $date->setTime(16, 00, 00);
            $date = $date->format('Y-m-d\TH:i:s');
        } catch (\Exception $e) {
            print_r("\nNO ModifiedDate FOUND FOR: " . $row->getSourceProperty("url") . " with working value:\"" . $modifiedDate . "\"\n");
            throw new MigrateSkipProcessException();
        }
    
    
          return $date;
    }
}
