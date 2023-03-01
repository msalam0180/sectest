<?php

namespace Drupal\investor_migrate\Plugin\migrate\source;

use Drupal\migrate\Row;
use Drupal\file\Plugin\migrate\source\d7\File;
use Drupal\Core\Database\Query\Condition;


/**
 * Investor file uploads - English.
 *
 * @MigrateSource(
 *  id = "investor_english",
 *  source_provider = "file",
 *  source_module = "investor_migrate"
 * )
 */
class FileEnglish extends File {

  /**
   * {@inheritdoc}
   */
  public function query() {
    $query = $this->select('file_managed', 'fm');
    $query->join('field_data_field_file_upload_english', 'fu', 'fu.field_file_upload_english_fid = fm.fid');
    $query->join('node', 'n', 'n.nid = fu.entity_id');
    $query->fields('fm', ['fid', 'uid', 'filename', 'uri', 'filemime', 'status', 'timestamp'])
      ->distinct()
      ->condition('n.type', 'news')
      ->orderBy('n.changed', 'DESC');

    // Filter by scheme(s), if configured.
    if (isset($this->configuration['scheme'])) {
      $schemes = array();
      // Accept either a single scheme, or a list.
      foreach ((array) $this->configuration['scheme'] as $scheme) {
        $schemes[] = rtrim($scheme) . '://';
      }
      $schemes = array_map([$this->getDatabase(), 'escapeLike'], $schemes);

      // uri LIKE 'public://%' OR uri LIKE 'private://%'
      $conditions = new Condition('OR');
      foreach ($schemes as $scheme) {
        $conditions->condition('uri', $scheme . '%', 'LIKE');
      }
      $query->condition($conditions);
    }
    return $query;
  }

}
