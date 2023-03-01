<?php


namespace Drupal\sec_release_importer\Form;

use Drupal\Core\Form\FormBase;
use Drupal\Core\Form\FormStateInterface;
use Drupal\Core\File\FileSystemInterface;
use Drupal\migrate\Plugin\MigrationInterface;

/**
 * Importer form
 */
class ImporterForm extends FormBase
{

  protected $sourceJson;
  /***
   * {@inheritdoc}
   */
  public function getFormId()
  {
    return "sec_release_importer_form";
  }

  /***
   * {@inheritdoc}
   */
  public function buildForm(array $form, FormStateInterface $form_state)
  {
    $form['importedfiles'] = [
      '#type' => 'file',
      '#title' => $this->t('Files to be Imported'),
      '#description' => t("Allowed extensions: <strong>JSON, PDF</strong>"),
      '#multiple' => TRUE,
      '#upload_location' => 'public://release_importer/',
      '#progress_message' => $this->t('Please wait...'),
      '#upload_validators' => array(
        'file_validate_extensions' => array('json pdf')
      ),
    ];

    $form['submit'] = [
      '#type' => 'submit',
      '#value' => $this->t('Import'),
      '#button_type' => 'primary',
    ];
    return $form;
  }

  /**
   * {@inheritdoc}
   */
  public function validateForm(array &$form, FormStateInterface $form_state)
  {
    $importedFiles = $this->getRequest()->files->get('files', [])['importedfiles'];
    if (empty($importedFiles)) {
      $form_state->setErrorByName('importedfiles', $this->t('Please upload files in order to execute this import.'));
    }
    $jsonFile = null;
    $uploadedFileList = [];
    $requiredFileList = [];
    foreach ($importedFiles as $importedFile) {
      if ($importedFile->getClientMimeType() == "application/json") {
        $jsonFile = $importedFile;
        $contents = file_get_contents($importedFile);
        try {
          $this->sourceJson = json_decode($contents, FALSE, 512, JSON_THROW_ON_ERROR);
          foreach ($this->sourceJson as $value) {
            if (!empty($value)) {
              foreach ($value as $item) {
                if (!empty($item->upload_files)) {
                  foreach ($item->upload_files as $requiredFile) {
                    if (str_contains($requiredFile->file, ".txt")
                      || str_contains($requiredFile->file, ".doc")
                      || str_contains($requiredFile->file, ".htm")
                      || str_contains($requiredFile->file, ".pdf")) {
                        $requiredFileList[] = $requiredFile->file;
                      }

                  }
                }
              }
            }
          }
        } catch (\Exception $e) {
          $form_state->setErrorByName('importedfiles', $this->t('Please include a valid json file in order to execute this import. ' . $e->getMessage()));
        }

      } else {
        if (str_contains($importedFile->getClientOriginalName(), ".txt")
          || str_contains($importedFile->getClientOriginalName(), ".doc")
          || str_contains($importedFile->getClientOriginalName(), ".htm")
          || str_contains($importedFile->getClientOriginalName(), ".pdf")) {
            $uploadedFileList[] = $importedFile->getClientOriginalName();
        }
      }
    }

    if (empty($jsonFile)){
      $form_state->setErrorByName('importedfiles', $this->t('Please include a json file in order to execute this import.'));
    }

    $missingFiles = array_diff($requiredFileList, $uploadedFileList);
    if (!empty($missingFiles)) {
      $form_state->setErrorByName('importedfiles', $this->t('The following files are required but were not be uploaded: ' . implode(', ', $missingFiles)));
    }

  }
  /**
   * {@inheritdoc}
   */
  public function submitForm(array &$form, FormStateInterface $form_state)
  {

    $importedFiles = $this->getRequest()->files->get('files', [])['importedfiles'];
    $uploadedPaths = [];
    $jsonFile = NULL;
    $importType = "";
    try {
      foreach ($importedFiles as $importedFile) {
        $uploadPath = "public://release_importer/".$importedFile->getClientOriginalName();
        $uploadedPaths[] = $uploadPath;
        \Drupal::service('file_system')->move($importedFile->getRealPath(), $uploadPath, FileSystemInterface::EXISTS_REPLACE);
        if ($importedFile->getClientMimeType() == "application/json") {
          $jsonFile = $uploadPath;
        }
      }

      if (!$jsonFile) {
        $this->messenger()->addError($this->t('Please include a json file in order to execute this import'));
        return;
      }

      $importType = $this->detectImportType();

      if (empty($importType) || !in_array($importType, array("lr", "ap", "ts", "aljo", "op", "id"))){
        $this->messenger()->addError($this->t('Please include a valid json file in order to execute this import'));
        return;
      }
      $primaryFileMigrationConfig = $this->getPrimaryFileMigrationConfig($importType);
      $secondaryFileMigrationConfig = $this->getSecondaryFileMigrationConfig($importType);

      //run multiple file migrations
      if ($secondaryFileMigrationConfig != null && $this->runFileMigration("releaseimportsecondaryfiles3", $secondaryFileMigrationConfig)) {
        if ($secondaryFileMigrationConfig != null && $this->runFileMigration("releaseimportsecondaryfiles2", $secondaryFileMigrationConfig)) {
          if ($secondaryFileMigrationConfig != null && $this->runFileMigration("releaseimportsecondaryfiles1", $secondaryFileMigrationConfig)) {
            if ($secondaryFileMigrationConfig != null && $this->runFileMigration("releaseimportsecondaryfiles", $secondaryFileMigrationConfig)) {
              if ($primaryFileMigrationConfig != null && $this->runFileMigration("releaseimportprimaryfiles", $primaryFileMigrationConfig)) {
                //now run the releaseimport migration
                if ($this->runMigration($importType)) {
                  $this->messenger()->addStatus($this->t('Your files were successfully imported.'));
                  //delete the json file once migration is complete.
                  \Drupal::service('file_system')->unlink($jsonFile);
                }
              }
            }
          }
        }
      }
    } catch (\Exception $e) {
        $this->messenger()->addError($this->t('Could not import the files provided. The error message is <em>@message</em>', ['@message' => $e->getMessage(),]));
    }
  }

  protected function getPrimaryFileMigrationConfig(String $importType){
    $staticFileType = "";
    switch ($importType) {
      case "ts":
        $staticFileType = "Trading Suspension Release";
        break;
      case "lr":
        $staticFileType = "Litigation Release";
        break;
      case "ap":
        $staticFileType = "Administrative Proceedings Release";
        break;
      case "id":
        $staticFileType = "ALJ Initial Decision Release";
        break;
      case "op":
        $staticFileType = "Opinions and Adjudicatory Orders Release";
        break;
      case "aljo":
        $staticFileType = "ALJ Order Release";
        break;
      default:
        break;
    }
    return [
      'source' => [
        'item_selector' => "/" . $importType,
        'constants' => [
          'staticFileType' => $staticFileType,
        ]
      ],
    ];
  }

  protected function getSecondaryFileMigrationConfig(String $importType){
    $staticFileType = "";
    switch ($importType) {
      case "ts":
        $staticFileType = "Trading Suspension Order";
        break;
      case "lr":
        $staticFileType = "Litigation Release";
        break;
      case "ap":
        $staticFileType = "Administrative Proceedings Order";
        break;
      case "id":
        $staticFileType = "ALJ Initial Decision Release";
        break;
      case "op":
        $staticFileType = "Opinions and Adjudicatory Orders Release";
        break;
      case "aljo":
        $staticFileType = "ALJ Order Release";
        break;
      default:
      break;
    }
    return [
      'source' => [
        'item_selector' => "/" . $importType,
        'constants' => [
          'staticFileType' => $staticFileType,
        ]
      ],
    ];
  }


  protected function runFileMigration(String $migrationId, array $migrationConfig){
    try {
      if (!empty($migrationConfig)) {
     		$fileType = $migrationConfig['source']['constants']['staticFileType'];
      	$migration = \Drupal::service('plugin.manager.migration')->createInstance($migrationId, $migrationConfig);
      	$migration->setTrackLastImported(TRUE);
      	$migration->getIdMap()->prepareUpdate();
     		$executable = new \Drupal\migrate_tools\MigrateExecutable($migration, new \Drupal\migrate\MigrateMessage());

        // \Drupal::logger('sec_release_importer')->debug(print_r($migration->getSourceConfiguration()['fields'], TRUE));
      	$migrationStatus = $executable->import();
      	// \Drupal::logger('sec_release_importer')->debug(print_r($migrationStatus, TRUE));
      	if ($migrationStatus == MigrationInterface::RESULT_FAILED) {
        	$this->messenger()->addError($this->t("Import failed."));
        	return false;
        	$executable->rollback();
      	}

      if ($migration->getIdMap()->errorCount() > 0) {
        $result = $migration->getIdMap()->getMessages()->fetchAll();
        foreach ($result as $error){
          $this->messenger()->addError($error->src_id . " failed with error: " . $error->message);
        }
        $executable->rollback();
        return false;
      } else {
        //display Links to newly migrated content
        $sql = "SELECT sourceId1, destid1 FROM migrate_map_" . $migrationId . " WHERE destid1 is not null and last_imported > :last_imported";
        $result = \Drupal::database()->query($sql, [':last_imported' => time() - 60,]);
        $nodes = $result->fetchAll();
        foreach ($nodes as $node) {
          $this->messenger()->addStatus($this->t('Imported ' . $fileType . ' <a target="_blank" href="/media/'.$node->destid1.'">'.$node->sourceId1.'</a>'));
        }
      }
    }
    } catch (\Exception $e) {
      $this->messenger()->addError($e->getMessage());
      return false;
    }
    return true;
  }

  protected function runMigration(String $migrationId){
    try {

      $migration = \Drupal::service('plugin.manager.migration')->createInstance("releaseimport" . $migrationId);
      $migration->setTrackLastImported(TRUE);
      $migration->getIdMap()->prepareUpdate();
      $executable = new \Drupal\migrate_tools\MigrateExecutable($migration, new \Drupal\migrate\MigrateMessage());
      $migrationStatus = $executable->import();
      // \Drupal::logger('sec_release_importer')->debug(print_r($migrationStatus, TRUE));
      if ($migrationStatus == MigrationInterface::RESULT_FAILED) {
        $this->messenger()->addError($this->t("Import failed."));
        return false;
        $executable->rollback();
      }

      if ($migration->getIdMap()->errorCount() > 0) {
        $result = $migration->getIdMap()->getMessages()->fetchAll();
        foreach ($result as $error) {
          $this->messenger()->addError($error->src_id . " failed with error: " . $error->message);
        }
        $executable->rollback();
        return false;
      } else {
        //display Links to newly migrated content
        $sql = "SELECT sourceId1, destid1 FROM migrate_map_releaseimport" . $migrationId . " WHERE destid1 is not null and last_imported > :last_imported";
        $result = \Drupal::database()->query($sql, [':last_imported' => time() - 60,]);
        $nodes = $result->fetchAll();
        foreach ($nodes as $node) {
          $this->messenger()->addStatus($this->t('Imported Release No. <a target="_blank" href="/node/'.$node->destid1.'">'.$node->sourceId1.'</a>'));
        }

        if (!empty($this->sourceJson->ap_case)) {
          $caseId = $this->sourceJson->ap_case[0]->field_case_id[0];
          $this->messenger()->addStatus($this->t('Imported AP Case <a target="_blank" href="/litigation/apdocuments/ap-' . $caseId . '">' . $caseId . '</a>'));
        }
      }
    } catch (\Exception $e) {
       $this->messenger()->addError($e->getMessage());
      return false;
    }
    return true;

  }

  protected function detectImportType() {
    if (!empty($this->sourceJson)) {
      // \Drupal::logger('sec_release_importer')->debug(print_r($this->sourceJson, TRUE));
      foreach ($this->sourceJson as $key => $value) {
        if (!empty($value) && $key != "aaer") return $key;
      }
    }
  }
}
