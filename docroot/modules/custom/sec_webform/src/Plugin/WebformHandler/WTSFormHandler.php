<?php

namespace Drupal\sec_webform\Plugin\WebformHandler;

use Drupal\file\Entity\File;
use Drupal\Core\File\FileSystemInterface;
use Drupal\sec_webform\Wts;
use Drupal\webform\Plugin\WebformHandlerBase;
use Drupal\webform\WebformSubmissionInterface;
use Symfony\Component\DependencyInjection\ContainerInterface;

define('SEC_WEBFORM_LOG', "sec_webform");
define('SEC_WEBFORM_URI_SCHEME', "private");
define('SEC_MANIFEST_FILE_NAME', 'manifest.txt');

/**
 * Create a new node entity from a webform submission.
 *
 * @WebformHandler(
 *   id = "wts",
 *   label = @Translation("Submit Form Data to WTS"),
 *   category = @Translation("External"),
 *   description = @Translation("Posts webform data submissions to WTS
 *   Server."), cardinality =
 *   \Drupal\webform\Plugin\WebformHandlerInterface::CARDINALITY_UNLIMITED,
 *   results =
 *   \Drupal\webform\Plugin\WebformHandlerInterface::RESULTS_PROCESSED,
 *   submission =
 *   \Drupal\webform\Plugin\WebformHandlerInterface::SUBMISSION_OPTIONAL,
 * )
 */
class WTSFormHandler extends WebformHandlerBase {

  /**
   * This is the service for WTS post request.
   *
   * @var Wts $wts
   *   A wts object.
   */
  protected Wts $wts;

  /**
   * Override parent and load file system service.
   *
   * @param \Symfony\Component\DependencyInjection\ContainerInterface $container
   * @param array $configuration
   * @param string $plugin_id
   * @param mixed $plugin_definition
   *
   * @return \Drupal\sec_webform\Plugin\WebformHandler\WTSFormHandler|\Drupal\webform\Plugin\WebformHandlerBase
   */
  public static function create(ContainerInterface $container, array $configuration, $plugin_id, $plugin_definition) {
    $instance = parent::create(
      $container,
      $configuration,
      $plugin_id,
      $plugin_definition
    );
    $instance->wts = $container->get('sec_webform.wts');
    return $instance;
  }

  /**
   * {@inheritdoc}
   * @throws \Drupal\Core\Archiver\ArchiverException
   * @throws \Drupal\Core\Entity\EntityStorageException
   */
  public function postSave(
    WebformSubmissionInterface $webform_submission,
    $update = TRUE
  ) {

    // Save this manifest to a text file.
    $submissionPath = SEC_WEBFORM_URI_SCHEME . "://webform" . DIRECTORY_SEPARATOR .
      $webform_submission->bundle() . DIRECTORY_SEPARATOR . $webform_submission->id();

    // Send webform submission datato the WTS service to do work for you.
    $this->wts->webformSubmission = $webform_submission;

    // Set Email field element name and should always before getting env keys.
    if ($emailElements = $this->getElementInstance('email')) {
      $this->wts->setClientEmailFieldElement($emailElements);
    }

    // Set env keys, check settings.php location
    // Keys in acquia-files/nobackup/apikeys/wts_apikey.php
    $this->wts->setApiUrl('SHP_API_URL');
    $this->wts->setApiKey('SHP_API_KEY');

    /**
     * @var \Drupal\Core\File\FileSystemInterface $this->wts->fileSystem
     */
    $this->wts->fileSystem->prepareDirectory(
      $submissionPath,
      FileSystemInterface::CREATE_DIRECTORY |
        FileSystemInterface::MODIFY_PERMISSIONS
    );

    $fileLocation = $submissionPath . DIRECTORY_SEPARATOR . SEC_MANIFEST_FILE_NAME;

    $manifestJSON = $this->createJSONManifest($webform_submission);

    if (file_put_contents($fileLocation, $manifestJSON)) {
      $this->wts->submitPost($webform_submission);
    }
  }

  /**
   * This will return the name(s) of the element given a type of element.
   *
   * @param $type
   *
   * @return array
   */
  public function getElementInstance($type): array {
    // Get element name of type email
    $elements_value = $this->webform->getElementsInitializedFlattenedAndHasValue();
    $elementName = [];
    foreach ($elements_value as $keyname => $property) {
      if ($property['#type'] == $type) {
        $elementName[] = $keyname;
      }
    }
    return $elementName;
  }

  /**
   * This can be customized, next time there is a new request to create new
   * WTS form. This creates json file that gets embedded in the
   * post request.
   *
   * @param WebformSubmissionInterface $webformSubmission
   *
   * @throws \Drupal\Component\Plugin\Exception\InvalidPluginDefinitionException
   * @throws \Drupal\Component\Plugin\Exception\PluginNotFoundException
   */
  public function createJSONManifest(WebformSubmissionInterface $webformSubmission) {

    // Get an array of the values from the submission.
    $values = $webformSubmission->getData();

    // Create Manifest object
    $manifestObject = (object) array_merge(
      [
        'id' => $webformSubmission->id(),
        'requestType' => $values['type_of_request'],
        'referenceIdReconsideration' => $values['reference_id_reconsideration'],
        'referenceIdSupplemental' => $values['reference_id_supplemental'],
        'letterDate' => $values['letter_date'],
        'requestCompany' => $values['request_company'],
        'requestProponent' => $values['request_proponent'],
        'submittingParty' => $values['submitting_party'],
        'companyName' => $values['company_name'],
        'contactName' => $values['contact_name'],
        'contactPhone' => $values['contact_phone'],
        'contactEmail' => $values['contact_email'],
        'proponentName' => $values['proponent_name'],
        'proponentContactName' => $values['proponent_contact_name'],
        'proponentContactPhone' => $values['proponent_contact_phone_number'],
        'proponentContactEmail' => $values['proponent_contact_email'],
        'proxyPrintDate' => $values['proxy_print_date'],
        'resolvedClause' => $values['resolved_clause'],
        'basesAsserted' => $this->getTermNames($values['bases_asserted']),
      ],
      // Merged the attached files.
      $this->getAttachmentFiles('documentName', $values)
    );

    // Convert Manifest to JSON
    return json_encode($manifestObject, JSON_PRETTY_PRINT);
  }

  /**
   * Ge term names from taxonomy ID.
   *
   * @param $ids
   *   Term Ids to get term names.
   *
   * @return array
   * @throws \Drupal\Component\Plugin\Exception\InvalidPluginDefinitionException
   * @throws \Drupal\Component\Plugin\Exception\PluginNotFoundException
   */
  public function getTermNames($ids): array {
    $terms = $this->entityTypeManager->getStorage('taxonomy_term')
      ->loadMultiple($ids);
    $termNames = [];
    if ($terms) {
      foreach ($terms as $term) {
        $termNames[] = $term->name->value;
      }
    }
    return $termNames;
  }

  /**
   * This process file attachments.
   *
   * @param string $keyName
   *   This needs to be name manually when this function is called.
   *   i.e. 'document' returns as key name 'document1' for the 1st value.
   *
   * @param array $values
   *
   * @return array
   */
  public function getAttachmentFiles(string $keyName, array $values): array {
    $fileManage = $this->webform->getElementsManagedFiles();
    $attachedData = [];
    foreach ($fileManage as $element) {
      $fileElement = $this->webform->getElement($element);
      for ($i = 1; $i <= $fileElement['#multiple']; $i++) {
        $attachedData[$keyName . $i] =
          $this->getFileName($values[$element][$i - 1]);
      }
    }
    return $attachedData;
  }

  /**
   * Retrieves a filename based on an $fid
   */
  function getFileName($fid) {
    if (!empty($fid)) {
      $tmpFile = File::load($fid);
      if (!empty($tmpFile)) {
        return $tmpFile->getFilename();
      }
    }
    return NULL;
  }
}
