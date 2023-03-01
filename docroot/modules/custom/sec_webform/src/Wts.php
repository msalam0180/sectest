<?php

namespace Drupal\sec_webform;

use Drupal\Core\Archiver\ArchiverException;
use Drupal\Core\File\FileSystemInterface;
use Drupal\Core\Routing\TrustedRedirectResponse;
use Drupal\webform\WebformSubmissionInterface;
use Exception;
use \ZipArchive;
use Drupal\Core\Logger\LoggerChannelFactoryInterface;
use GuzzleHttp\Psr7;
use GuzzleHttp\Exception\ClientException;
use GuzzleHttp\Exception\RequestException;
use GuzzleHttp\Exception\GuzzleException;
use GuzzleHttp\Exception\ConnectException;

class Wts {

  /**
   * A file system provides helpers that operate on files and stream wrappers.
   *
   * @var FileSystemInterface
   */
  public FileSystemInterface $fileSystem;

  /**
   * The logger factory.
   *
   * @var LoggerChannelFactoryInterface
   */
  protected LoggerChannelFactoryInterface $loggerFactory;

  /**
   * Environment key to check.
   *
   */
  protected $apiKey;

  /**
   * API URL to send post request.
   */
  protected $apiUrl;

  /**
   * @var string
   */
  protected string $queryUri = '';

  /**
   * The underlying ZipArchive instance that does the heavy lifting.
   *
   * @var \ZipArchive
   */
  protected $zip;

  /**
   * This is the webform submission data.
   */
  public WebformSubmissionInterface $webformSubmission;

  /**
   * Required element field name for email.
   */
  protected $clientEmailFieldElement;

  /**
   * Wts constructor.
   *
   * @param $file_system
   * @param $logger_factory
   */
  public function __construct($file_system, $logger_factory) {
    $this->fileSystem = $file_system;
    $this->loggerFactory = $logger_factory;
  }

  /**
   * This creates the manifest in /tmp/[submissionid].zip file and sends data
   * to wts.
   *
   * @param WebformSubmissionInterface $webFormSubmission
   *
   * @throws \Drupal\Core\Archiver\ArchiverException
   * @throws \Drupal\Core\Entity\EntityStorageException
   */
  public function submitPost(WebformSubmissionInterface $webFormSubmission) {

    if (class_exists('\ZipArchive')) {

      $zipFilePath = $this->fileSystem->getTempDirectory() .
        DIRECTORY_SEPARATOR . $webFormSubmission->id() . ".zip";
      $zip = new \ZipArchive();

      if ($zip->open($zipFilePath, ZipArchive::CREATE |
        ZipArchive::OVERWRITE) === TRUE) {
        // Store the path into the variable
        $zipPath = $this->fileSystem->realpath(SEC_WEBFORM_URI_SCHEME . "://") . "/webform" .
          DIRECTORY_SEPARATOR . $webFormSubmission->bundle() . DIRECTORY_SEPARATOR .
          $webFormSubmission->id() . "/";
        $zipBaseName = basename($zipFilePath);
        $dir = opendir($zipPath);
        while ($file = readdir($dir)) {
          if (is_file($zipPath . $file)) {
            $zip->addFile($zipPath . $file, $file);
          }
        }
        $zip->close();
        try {
          $body = Psr7\Utils::tryFopen($zipFilePath, 'r');
          $response = \Drupal::httpClient()->post(
            $this->getApiUrl(),
            [
              'headers' => [
                'Content-Type' => 'application/zip',
                'Content-Length' => filesize($zipFilePath),
                'API-KEY' => $this->getApiKey(),
                'Appian-Document-Name' => $zipBaseName,
              ],
              'body' => $body,
              'connect_timeout' => 1,
              'timeout' => 30,
            ]
          );
          if ($response->getStatusCode() == 200) {
            $this->loggerFactory->get(SEC_WEBFORM_LOG)
              ->info("Successfully submitted webform #" .
                $webFormSubmission->id() . " to WTS.");
          }
        } catch (ClientException $client_exception) {
          $this->loggerFactory->get(SEC_WEBFORM_LOG)
            ->error(print_r(
              $client_exception->getMessage(),
              TRUE
            ));
          $this->handleError($webFormSubmission);
        } catch (RequestException $request_exception) {
          $this->loggerFactory->get(SEC_WEBFORM_LOG)
            ->error(print_r(
              $request_exception->getMessage(),
              TRUE
            ));
          $this->handleError($webFormSubmission);
        } catch (GuzzleException $other_exception) {
          $this->loggerFactory->get(SEC_WEBFORM_LOG)
            ->error(print_r(
              $other_exception->getMessage(),
              TRUE
            ));
          $this->handleError($webFormSubmission);
        } catch (ConnectException $connect_exception) {
          $this->loggerFactory->get(SEC_WEBFORM_LOG)
            ->error(print_r(
              $connect_exception->getMessage(),
              TRUE
            ));
          $this->handleError($webFormSubmission);
        } catch (Exception $e) {
          $this->loggerFactory->get(SEC_WEBFORM_LOG)
            ->error(print_r($e->getMessage(), TRUE));
          $this->handleError($webFormSubmission);
        }
      } else {
        $this->loggerFactory->get(SEC_WEBFORM_LOG)
          ->error("Unable to create " . $zipFilePath);
        throw new ArchiverException("Cannot open '$zipFilePath'");
      }
    }
  }

  /**
   * Handle error by logging, prevent sending outgoing email to contact_email
   * and display debugging and/or exception message.
   *
   * @param \Drupal\webform\WebformSubmissionInterface $webform_submission
   *
   * @throws \Drupal\Core\Entity\EntityStorageException
   */
  protected function handleError(WebformSubmissionInterface $webform_submission) {
    $this->loggerFactory->get(SEC_WEBFORM_LOG)
      ->error("Error submitting webform #" . $webform_submission->id() . "
      to WTS. Deleting submission and redirecting user back to form.");

    //blank out the user email to prevent outgoing messages
    $this->clearElementValues(
      $webform_submission,
      $this->getClientEmailFieldElement()
    );

    //get the submission url to kick user back
    $sourceUrl = $webform_submission->getSourceUrl()->toString() . "?msg=fail";
    //delete this webform to prevent issues with resubmitting
    $webform_submission->delete();

    //send user back to submission url
    $response = new TrustedRedirectResponse($sourceUrl);
    $response->send();
  }

  /**
   * This will clear the all email element value, to prevent sending email to
   * client.
   *
   * @param $webformSubmission
   * @param array $elementNames
   */
  protected function clearElementValues($webformSubmission, array $elementNames) {
    foreach ($elementNames as $element) {
      $webformSubmission->setElementData($element, "");
    }
  }

  /**
   * @return string
   */
  protected function getApiKey(): string {
    return $this->apiKey;
  }

  /**
   * @return string
   */
  protected function getApiUrl(): string {
    return $this->apiUrl . $this->queryUri;
  }

  /**
   * @param string $apiUrl
   */
  public function setApiUrl(string $apiUrl): void {
    $this->apiUrl = $this->getEnvironmentVar($apiUrl);
  }

  /**
   * @param string $apiKey
   */
  public function setApiKey(string $apiKey): void {
    $this->apiKey = $this->getEnvironmentVar($apiKey);
  }

  /**
   * @param $var
   *
   * @return string
   */
  private function getEnvironmentVar($var): string {
    $value = getenv($var);
    if ($value) {
      return $value;
    } else {
      $this->throwError($var);
    }
  }

  /**
   * Handles the error when getting environment variables.
   *
   * @throws \Drupal\Core\Entity\EntityStorageException
   */
  public function throwError($val) {
    $msg = "No '$val' value has been set for this environment.";
    $this->loggerFactory->get(SEC_WEBFORM_LOG)
      ->error($msg);
    $this->handleError($this->webformSubmission);
  }

  /**
   * @return array
   */
  public function getClientEmailFieldElement(): array {
    return $this->clientEmailFieldElement;
  }

  /**
   * @param array $clientEmailFieldElement
   */
  public function setClientEmailFieldElement(array $clientEmailFieldElement): void {
    $this->clientEmailFieldElement = $clientEmailFieldElement;
  }

  /**
   * This is an optional in case there is a query argument needed for the
   * environment variable.
   *
   * @param string $queryUri
   */
  public function setQueryUri(string $queryUri = ''): void {
    $this->queryUri = $queryUri;
  }
}
