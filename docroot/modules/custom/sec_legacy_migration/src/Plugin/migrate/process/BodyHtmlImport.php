<?php

namespace Drupal\sec_legacy_migration\Plugin\migrate\process;

/**
 * @file
 * Contains \Drupal\sec_legacy_migration\Plugin\migrate\process\BodyHtmlImport.
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
 *   id = "body_html_import"
 * )
 */
class BodyHtmlImport extends ProcessPluginBase
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
        $shouldRemoveSubheadings = !empty($this->configuration['remove_subheadings']) ?: false;

        // Get content for body (outer html of DIV).
        $dom = Html::load($value);
        $xpath = new \DOMXPath($dom);
        $htmlBody = "";
        $returnVal = [];
        $body = $xpath->query('//div[@id="main-content"]/div[1]');
        $table = $xpath->query('//body/table[2]/tr/td[3]');

        if ($body->length == 0) {
            if ($table->length == 0) {
                $table = $xpath->query('//body/table[2]/tbody/tr/td[3]');
            }
            //check if this is just an html dump
            if ($table->length == 0 && $xpath->query('//body/table')->length <= 1) {
                $table = $xpath->query('//body');
                $htmlBody = $dom->saveHTML($table->item(0));
            }
            if ($table->length == 0) {
                print_r("\nNo body value for ". $row->getSourceProperty("id")." \n" . "\n");
                throw new MigrateSkipProcessException();
            } else {
                $tableBody = $dom->saveHTML($table->item(0));
                if (strpos($tableBody, "<i>") !== false) {
                    //remove footer table which is always the last table and the url/hr preceding it
                    $noTable = explode("<i>", $tableBody);
                    array_pop($noTable);
                    //remove display titles
                    $noH1 = explode('</h1>', implode("<i>", $noTable));

                    if (sizeof($noH1) > 1) {
                        if ((substr($noH1[1], 0, 6) === "</font>")) { // Strip the font tags
                            $htmlBody = substr($noH1[1], 7);
                        } else {
                            $htmlBody = $noH1[1];
                        }
                    } else {
                        $htmlBody = $noH1[0];
                        //print_r("\nNo H1 in ". $row->getSourceProperty("url")." Possible redirect page\n");
                    }

                    if ($shouldRemoveSubheadings) {
                        $htmlBody = preg_replace("/\<h2(.*)\>(.*)\<\/h2\>/", "", $htmlBody); //removes regular H2s
                        $htmlBody = preg_replace("/\<h2(.*)\>(.*)\n\<br\>(.*)\<\/h2\>/", "", $htmlBody); //remove H2s with line break
                        $htmlBody = preg_replace("/\<h3(.*)\>(.*)\<\/h3\>/", "", $htmlBody); //removes regular H3s
                        $htmlBody = preg_replace("/\<h3(.*)\>(.*)\n\<br\>(.*)\<\/h3\>/", "", $htmlBody); //remove H3s with line break
                    }
                } else {
                    $htmlBody = $tableBody;
                }
            }
        } else {
            $htmlBody = $dom->saveHTML($body->item(0));
        }

        $htmlBody = utf8_encode($htmlBody);
        $htmlBody = str_replace(["Ã", "Â", ""], "", $htmlBody);
        $returnVal['value'] = $htmlBody;
        $returnVal['format'] = 'full_html';

        return $returnVal;
    }
}

