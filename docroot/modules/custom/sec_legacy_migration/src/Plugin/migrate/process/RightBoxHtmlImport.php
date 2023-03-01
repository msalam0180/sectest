<?php

namespace Drupal\sec_legacy_migration\Plugin\migrate\process;

/**
 * @file
 * Contains \Drupal\sec_legacy_migration\Plugin\migrate\process\RightBoxHtmlImport.
 */

use Drupal\migrate\MigrateExecutableInterface;
use Drupal\migrate\MigrateSkipProcessException;
use Drupal\migrate\ProcessPluginBase;
use Drupal\migrate\Row;
use Drupal\node\Entity\Node;
use Drupal\Component\Utility\Html;

/**
 * Imports HTML Content and sets format to full_html
 *
 * @MigrateProcessPlugin(
 *   id = "rightbox_html_import"
 * )
 */
class RightBoxHtmlImport extends ProcessPluginBase
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

        // Get content for rightbox (outer html of DIV).
        $rightDom = Html::load($value);
        $rightXpath = new \DOMXPath($rightDom);
        $rightbox = $rightXpath->query('//div[@id="main-content"]/div[2]');
        $returnVal = [];

        if ($rightbox->length == 0) {
            throw new MigrateSkipProcessException();                    
        }

        $htmlBody = $rightDom->saveHTML($rightbox->item(0));
        //print_r("\nRightbox value inserted for ". $row->getSourceProperty("url")." \n" . "\n");
        $returnVal['value'] = $htmlBody;
        $returnVal['format'] = 'full_html';
        
        return $returnVal;
    }
}

