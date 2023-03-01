<?php

namespace Drupal\sec_build\Form;

use Drupal\Core\Form\FormBase;
use Drupal\core\Form\FormStateInterface;

class IDDUpdateStaticFileFieldBatchForm extends FormBase {

  /**
   *  {@inheritdoc}.
   */
  public function getFormId() {
    return 'idd_update_static_file_field_batch_form';
  }

  /**
   *  {@inheritdoc}.
   */
  public function buildForm(array $form, FormStateInterface $form_state) {

    $form['text'] = [
      '#type' => 'markup',
      '#markup' => '<div>Click Start to begin.</div>',
    ];

    $form['batch_size'] = [
      '#type' => 'textfield',
      '#title' => 'Batch size',
      '#default_value' => 5,
    ];

    $form['submit'] = [
      '#type' => 'submit',
      '#value' => 'Start',
    ];

    return $form;
  }

  /**
   *  {@inheritdoc}.
   */
  public function submitForm(array &$form, FormStateInterface $form_state) {
    $batch_size = (int) $form_state->getValue('batch_size');
    $nodeStorage = \Drupal::service('entity_type.manager')->getStorage('node');
    $nids = $nodeStorage->getQuery()->condition('type','ba')->execute();
    $ops = [];
    $nidChunks = array_chunk($nids, $batch_size);

    foreach ($nidChunks as $nidChunk) {
      $ops[] = [
        'Drupal\sec_build\Form\IDDUpdateStaticFileFieldBatchForm::updateIDDContent',
        [$nidChunk],
      ];
    }

    $batch = [
      'title' => 'Processing migration update',
      'operations' => $ops,
      'init_message' => t('Batch is starting.'),
      'progress_message' => t('Processed @current out of @total.'),
      'error_message' => t('Batch has encountered an error.'),
      'finished' => 'Drupal\sec_build\Form\IDDUpdateStaticFileFieldBatchForm::finishCallback',
    ];

    batch_set($batch);
  }

  /**
   * Update IDD Content
   */
  public function updateIDDContent($nidChunk, $context) {
    $db = \Drupal::database();
    $nodeStorage = \Drupal::service('entity_type.manager')->getStorage('node');
    $paragraphStorage = \Drupal::service('entity_type.manager')->getStorage('paragraph');

    foreach ($nidChunk as $nid) {
      $node = $nodeStorage->load($nid);
      $paragraphItems = $node->get('field_related_documents')->getValue();
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
          $query->condition('mnm.name', 'Static File');
          $query->condition('mnmr.nid', $staticFileNid);
          $query->range(0, 1);
          $results = $query->execute()
            ->fetchAllKeyed(0, 0);

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
  }

  /**
   * Batch finish callback
   */
  public function finishCallback($success, $results, $operations, $elapsed) {
    \Drupal::messenger()->addWarning('Process completed');
  }

}
