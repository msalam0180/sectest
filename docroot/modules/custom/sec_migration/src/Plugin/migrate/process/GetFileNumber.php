<?php

namespace Drupal\sec_migration\Plugin\migrate\process;

/**
 * @file
 * Contains \Drupal\sec_migration\Plugin\migrate\process\GetFileNumber.
 */

use Drupal\migrate\MigrateExecutableInterface;
use Drupal\migrate\MigrateSkipProcessException;
use Drupal\migrate\ProcessPluginBase;
use Drupal\migrate\Row;

/**
 * GetFileNumber returns the file number from a pdf or txt file extracted from legacy AWS content listings
 *
 * @see \Drupal\migrate\Plugin\MigrateProcessInterface
 *
 * @MigrateProcessPlugin(
 *   id = "get_file_number"
 * )
 */
class GetFileNumber extends ProcessPluginBase {

  /**
   * {@inheritdoc}
   */
  public function transform($value, MigrateExecutableInterface $migrate_executable, Row $row, $destination_property) {
    $id = trim($row->getSourceProperty("id"));

    if ($this->isValidFileNumber($id)) {
      return $id;
    }

    //check if File No is in respondents text
    $respondents = $row->getSourceProperty("respondents");

    $regex = "/(?s)File Nos?\. (.+?(?= |,|;|$))/";
    preg_match($regex, $respondents, $matches);

    if (!empty($matches[0])) {
      return $matches[1];
    }



    //check if we have a file we can parse
    if (empty($value)) {
      // Skip this item if there's no string value.
      throw new MigrateSkipProcessException();
    }

    $fileNumber = "";

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
        if (!empty($details) && !empty($details['Keywords'])) {
          $keywords = utf8_encode($details['Keywords']);
          $keywords = str_replace("–","-",$keywords);
          $keywords = explode(";", $keywords);
          if (count($keywords) > 1) {
            if (strpos($keywords[1], "File Nos.") !== false) {
              $keywords = str_replace("File Nos. ", "", $keywords[1]);
              if (strpos($keywords, ", 3-") ){
                $multipleFileNumbers = explode(",", $keywords);
              } else {
                $multipleFileNumbers = explode(" and ", $keywords);
              }

              $fileNumber = array_map('trim', $multipleFileNumbers);

            } else {
              $fileNumber = trim(str_replace("File No. ", "", $keywords[1]));
            }
          }
        }
        unset($pdf);
      } elseif (strpos($value, '.txt') !== false) {
        $txt_file = file_get_contents($value);
        $lines = explode("\n", $txt_file);
        array_shift($lines);

        foreach ($lines as $line) {
          if (str_starts_with($line, "File No")) {
            $fileNumber = trim(explode(".", $line)[1]);
            break;
          }
        }
      }

      if (is_array($fileNumber) && $this->isValidFileNumber($fileNumber[0])) {
        return $fileNumber;
      }

      $fileNumber = trim($fileNumber);
      if ($this->isValidFileNumber($fileNumber)) {
        return $fileNumber;
      }
      return null;
    } catch (\Throwable $th) {
      throw new MigrateSkipProcessException();
    } catch (\Error $e) {
      throw new MigrateSkipProcessException();
    }

  }

  public function isValidFileNumber($fileNumber) {
    if (
      str_starts_with($fileNumber, "3-")
      || str_starts_with($fileNumber, "8-")
      || str_starts_with($fileNumber, "24S")
      || str_starts_with($fileNumber, "24NY")
      || str_starts_with($fileNumber, "24W")
    ) {
      return true;
    }
    return false;


  }
}
