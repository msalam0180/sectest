<?php

namespace Drupal\sec_migration\Plugin\migrate\source;

use Drupal\migrate\Row;
use Drupal\migrate_source_directory\Plugin\migrate\source\Directory;

/**
 * Imports AP Filing XML Content
 *
 * @MigrateSource(
 *   id = "ap_filing",
 *   source_module = "sec_migration",
 * )
 */
class APFiling extends Directory {

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
   *   A new row, one for each filename in the source releaseItem without a releaseNumber
   */
  public function getYield(\Generator $file) {
    foreach ($file as $row) {
      $content = file_get_contents($row['source_file_pathname']);
      $data = simplexml_load_string($content);

      if (!empty($data->apCaseHeader)) {
        foreach($data->releaseItem as $item){
          if ($item->releaseNumber == "") {
            $filePath = reset($item->secLink);
            $filePath = trim(str_replace(["\r","\n"], "", $filePath));
            $title = reset($item->title);
            if (strlen($title) > 255) {
              $title = substr($title, 0, 252 ) . "...";
            }
            $rowId = end(explode("/", $filePath));
            $new_row = $row;
            $new_row['title'] = $title;
            $new_row['date'] = reset($item->date);
            $new_row['file_number'] =  reset($data->apCaseHeader->fileNumbers->fileNumber);
            $new_row['file_path'] =  $filePath;
            $new_row['id'] = $rowId;
            yield ($new_row);
          }
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
