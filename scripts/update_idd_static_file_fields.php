<?php

$db = \Drupal::database();
$nodeStorage = \Drupal::service('entity_type.manager')->getStorage('node');

$nids = \Drupal::service('entity_type.manager')->getStorage('node')->getQuery()->condition('type','ba')->execute();

foreach ($nids as $nid) {
  $node = \Drupal::service('entity_type.manager')->getStorage('node')->load($nid);
  $paragraphItems = $node->get('field_related_documents')->getValue();
  $paragraphStorage = \Drupal::entityTypeManager()->getStorage('paragraph');
  $ids = array_column($paragraphItems, 'target_id');
  $paragraphs = $paragraphStorage->loadMultiple($ids);
  $newParagraphs = [];

  foreach ($paragraphs as $paragraph) {
    $fileItem = $paragraph->get('field_static_file')->getValue();

    if (!empty($fileItem)) {
      $staticFileNid = $fileItem[0]['target_id'];
      $query = $db->select('migrate_node_media_route', 'mnmr')
        ->fields('mnmr', ['mid']);
      $query->innerJoin('migrate_node_media', 'mnm', 'mnm.id = mnmr.map_id');
      $query->condition('mnm.name', 'sf');
      $query->condition('mnmr.nid', $staticFileNid);
      $query->range(0, 1);
      $results = $query->execute()
        ->fetchAllKeyed(0,0);

      if (!empty($results)) {
        $newMediaTarget = array_pop($results);
        $paragraph->set('field_static_file_media', ['target_id' => $newMediaTarget]);
        $paragraph->save();
      }
    }

    $newParagraphs[] = [
      'target_id' => $paragraph->id(),
      'target_revision_id' => $paragraph->getRevisionId(),
    ];
  }

  $node->set('field_related_documents', $newParagraphs);
  $node->setSyncing(TRUE);
  $node->save();
}
