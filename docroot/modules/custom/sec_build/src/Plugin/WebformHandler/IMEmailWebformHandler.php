<?php

namespace Drupal\sec_build\Plugin\WebformHandler;

use Drupal\webform\Plugin\WebformHandler\EmailWebformHandler;
use Drupal\webform\WebformSubmissionInterface;

/**
 * Emails a webform submission.
 *
 * @WebformHandler(
 *   id = "im_email",
 *   label = @Translation("IM Email"),
 *   category = @Translation("Notification"),
 *   description = @Translation("Sends a webform submission via an email and removes the submission."),
 *   cardinality = \Drupal\webform\Plugin\WebformHandlerInterface::CARDINALITY_UNLIMITED,
 *   results = \Drupal\webform\Plugin\WebformHandlerInterface::RESULTS_PROCESSED,
 *   submission = \Drupal\webform\Plugin\WebformHandlerInterface::SUBMISSION_OPTIONAL,
 *   tokens = TRUE,
 * )
 */
class IMEmailWebformHandler extends EmailWebformHandler {

  /**
   * {@inheritdoc}
   */
  public function sendMessage(WebformSubmissionInterface $webform_submission, array $message) {


    $webform_entity = \Drupal::service('entity_type.manager')->getStorage('webform_submission')->load($webform_submission->id());

    // Insert webform submission record so we know
    if ($webform_entity) {
      $db = \Drupal::database();
      $table = 'sec_im_no_action_submissions';
      if ($db->schema()->tableExists($table)) {
        $insert = $db->insert($table)
          ->fields([
            'sid' => $webform_submission->id(),
            'created' => $webform_entity->created->value,
          ])
          ->execute();
      }
    }

    // Send mail as usual
    $result = parent::sendMessage($webform_submission, $message);

    // Delete webform submission
    if ($webform_entity) {
      $webform_entity->delete();
    }

    return $result;
  }

}