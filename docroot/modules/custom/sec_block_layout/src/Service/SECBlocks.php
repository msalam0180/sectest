<?php

namespace Drupal\sec_block_layout\Service;

class SECBlocks {
  public function getIdFromName($block_name) {
    try {
      $sql = <<<SQL
        SELECT id
          FROM block_content_field_data
         WHERE info = :block_name
           AND status = 1
SQL;
      $connection = \Drupal::database();
      $query = $connection->query($sql, [':block_name' => $block_name]);
      $results = $query->fetchAll();
      if (sizeof($results) == 0) {
        return array('status' => 0, 'message' => sprintf('Block not found for %s', $block_name));
      }
      if (sizeof($results) > 1) {
        return array('status' => 0, 'message' => sprintf('Too many blocks found for %s', $block_name));
      }
      return array('status' => 1, 'block_id' => intval($results[0]->id));
    }

    catch (Exception $e) {
      return array('status' => 0, 'message' => $e->getMessage());
    }

  }

}
