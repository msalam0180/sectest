<?php

namespace Drupal\sec_migration\Plugin\migrate\source;

use Drupal\migrate\Row;
use Drupal\migrate_source_directory\Plugin\migrate\source\Directory;

/**
 * Imports AP Case XML Content
 *
 * @MigrateSource(
 *   id = "ap_case",
 *   source_module = "sec_migration",
 * )
 */
class APCase extends Directory {

  /**
   * {@inheritdoc}
   */
  public function initializeIterator() {
    $file = parent::initializeIterator();
    return $this->getYield($this->getGenerator($file));
  }

  /**
   * A generic generator converter since Directory parent class returns an ArrayIterator
   *
   * @param \Iterator $records
   * @return \Generator
   *   The records generator.
   */
  protected function getGenerator(\Iterator $records) {
    foreach ($records as $record) {
      yield $record;
    }
  }


  /**
   * Prepares multiple rows per item
   *
   * @param \Generator $file
   *   The source XML file object.
   *
   * @return \Generator
   *   A new row, one for each filename in the source releaseItem with a releaseNumber
   */
  public function getYield(\Generator $file) {
    foreach ($file as $row) {
      $content = file_get_contents($row['source_file_pathname']);
      $data = simplexml_load_string($content);
      $respondents = implode(", ", (array)$data->apCaseHeader->respondents->respondent);
      $fileNumber = reset($data->apCaseHeader->fileNumbers->fileNumber);
      foreach($data->releaseItem as $item){
        if ($item->releaseNumber != "") {
          $fileName = end(explode("/", reset($item->secLink)));
          $new_row = $row;
          $new_row['respondents'] = $respondents;
          $new_row['title'] = reset($item->title);
          $new_row['date'] = reset($item->date);
          $new_row['file_number'] =  $fileNumber;
          $new_row['file_path'] =  reset($item->secLink);
          $new_row['file_url'] = "https://www.sec.gov" . reset($item->secLink);
          $new_row['file_name'] = $fileName;
          $new_row['other_release_numbers'] = (array)$item->otherReleaseNumbers->otherReleaseNumber;
          $new_row['id'] = reset($item->releaseNumber);
          yield ($new_row);
        }
      }

    }
  }

  /**
   * {@inheritdoc}
   */
  public function getIds() {
    return [
      'id' => [
        'type' => 'string',
        'alias' => 'id',
      ]
    ];
  }
}
