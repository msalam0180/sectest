<?php

namespace Drupal\sec_migration\Plugin\migrate\process;

/**
 * @file
 * Contains \Drupal\sec_migration\Plugin\migrate\process\GetReleaseTitle.
 */

use Drupal\migrate\MigrateExecutableInterface;
use Drupal\migrate\MigrateSkipProcessException;
use Drupal\migrate\ProcessPluginBase;
use Drupal\migrate\Row;

/**
 * GetReleaseTitle returns the file number from a pdf or txt file extracted from legacy AWS content listings
 *
 * @see \Drupal\migrate\Plugin\MigrateProcessInterface
 *
 * @MigrateProcessPlugin(
 *   id = "get_release_title"
 * )
 */
class GetReleaseTitle extends ProcessPluginBase {

  /**
   * {@inheritdoc}
   */
  public function transform($value, MigrateExecutableInterface $migrate_executable, Row $row, $destination_property) {

    //check if we have a file we can parse
    if (empty($value)) {
      // Skip this item if there's no string value.
      throw new MigrateSkipProcessException();
    }

    $releaseTitle = "";

    if (strpos($value, ".htm") !== false) {
      throw new MigrateSkipProcessException();
    }

    try {
      if (strpos($value, ".pdf") !== false) {

        //if file is greater than 15mb skip it
        if (str_contains($value, "public://") && filesize($value) > 15000000) {
          var_dump("Skip parsing pdf for large file: " . $value);
          throw new MigrateSkipProcessException();
        }

        $config = new \Smalot\PdfParser\Config();
        // Whether to retain raw image data as content or discard it to save memory
        $config->setRetainImageContent(false);
        // Memory limit to use when de-compressing files, in bytes
        $config->setDecodeMemoryLimit(1000000);
        $parser = new \Smalot\PdfParser\Parser([], $config);
        $pdf = $parser->parseFile($value);
        $details  = $pdf->getDetails();

        if (!empty($details) && !empty($details['Subject'])) {
          $releaseTitle = $details['Subject'];
        }
        unset($pdf);
      } elseif (strpos($value, '.txt') !== false) {
        $txt_file = file_get_contents($value);
        $lines = explode("\n", $txt_file);
        array_shift($lines);

        foreach ($lines as $line) {
          if (str_starts_with($line, "In the Matter of ")) {
            $releaseTitle = trim(explode(":", $line)[1]);
            break;
          }
        }
      }
      return utf8_encode($releaseTitle);
    } catch (\Throwable $th) {
      throw new MigrateSkipProcessException();
    } catch (\Error $e) {
      throw new MigrateSkipProcessException();
    }

  }
}
