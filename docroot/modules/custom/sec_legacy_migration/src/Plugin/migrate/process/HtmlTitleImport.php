<?php

namespace Drupal\sec_legacy_migration\Plugin\migrate\process;

/**
 * @file
 * Contains \Drupal\sec_legacy_migration\Plugin\migrate\process\HtmlTitleImport.
 */
use Drupal\migrate\MigrateExecutableInterface;
use Drupal\migrate\MigrateSkipProcessException;
use Drupal\migrate\ProcessPluginBase;
use Drupal\migrate\Row;
use Drupal\node\Entity\Node;
use Drupal\Component\Utility\Html;

/**
 * Imports HTML Content and find the Title value
 *
 * @MigrateProcessPlugin(
 * id = "html_title_import"
 * )
 */
class HtmlTitleImport extends ProcessPluginBase
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
        $dom = Html::load($value);
        $xpath = new \DOMXPath($dom);
        $title = "";
    
        foreach ( $xpath->query("//h1") as $node ) {
            $h1 = $dom->saveHTML($node);
            $title = strip_tags($h1, '<p><a><br><span><i><em><sup>');
        }
    
        if (empty($title)) {
            foreach ( $xpath->query("//title") as $titlenode ) {
                if (! strstr($titlenode->textContent, "The Page You Requested Has Moved")) {
                    $title = $titlenode->textContent;
                } else if (! empty($titlenode->textContent)) {
                    print_r("\nNO TITLE FOUND FOR: " . $row->getSourceProperty("url") . " because \"" . $titlenode->textContent . "\"\n");
                } else {
                    print_r("\nNO TITLE FOUND FOR: " . $row->getSourceProperty("url") . " because there was neither an h1 nor a title element present.\n");
                }
            }
        }
    
        return substr($title, 0, 255);
    }
}

