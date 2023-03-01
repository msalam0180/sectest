<?php

namespace Drupal\sec_webform\Plugin\WebformHandler;

use Drupal\file\Entity\File;
use Drupal\Core\File\FileSystemInterface;
use Drupal\webform\Plugin\WebformHandlerBase;
use Drupal\webform\WebformSubmissionInterface;
use \ZipArchive;
use GuzzleHttp\Psr7;
use GuzzleHttp\Exception\ClientException;
use GuzzleHttp\Exception\RequestException;
use GuzzleHttp\Exception\GuzzleException;
use GuzzleHttp\Exception\ConnectException;
use Drupal\Core\Routing\TrustedRedirectResponse;
/**
 * Create a new node entity from a webform submission.
 *
 * @WebformHandler(
 *   id = "Submit to WTS",
 *   label = @Translation("Submit to WTS"),
 *   category = @Translation("External"),
 *   description = @Translation("Posts webform submissions to the WTS Server."),
 *   cardinality = \Drupal\webform\Plugin\WebformHandlerInterface::CARDINALITY_UNLIMITED,
 *   results = \Drupal\webform\Plugin\WebformHandlerInterface::RESULTS_PROCESSED,
 *   submission = \Drupal\webform\Plugin\WebformHandlerInterface::SUBMISSION_OPTIONAL,
 * )
 */

class WTSHandler extends WebformHandlerBase
{

    /**
     * {@inheritdoc}
     */
    public function postSave(WebformSubmissionInterface $webform_submission, $update = true)
    {
        // Get an array of the values from the submission.
        $values = $webform_submission->getData();

        //first check if the API KEY is not available, return
        $wtsApiKey = getenv('WTS_API_KEY');
        $wtsApiUrl = getenv('WTS_API_URL');
    
        if (empty($wtsApiKey)) {
          \Drupal::logger('sec_webform')->error("No WTS_API_KEY value has been set for this environment");
          return;
        }

        if (empty($wtsApiUrl)) {
          \Drupal::logger('sec_webform')->error("No WTS_API_URL value has been set for this environment");
          return;
        }

        //for this webform, we will submit file over to WTS and add all fields into a json format
        $uploadedFiles = json_decode(json_encode($values['upload_your_request'], true));
        $manifestObject = (object) [
          'id' => $webform_submission->id(),
          'contactName' => $values['your_name'],
          'contactEmail' => $values['your_email_address'],
          'contactPhone' => $values['your_phone_number'],
          'timeOfDayPreference' => $values['best_time_of_day_eastern_us_time_to_reach_you_by_phone'],
          'initial' => strtolower($values['please_also_indicate_whether_this_is_an_initial_or_a_revised_sub']),
          'divisionOffice' => $values['to_assis_the_staff_please_direct_your_request_to_the_appropriate'],
          'requestType' => $values['request_type'],
          'documentName1' => $this->getFileName($uploadedFiles[0]),
          'documentName2' => $this->getFileName($uploadedFiles[1]),
          'documentName3' => $this->getFileName($uploadedFiles[2]),
          'documentName4' => $this->getFileName($uploadedFiles[3]),
          'documentName5' => $this->getFileName($uploadedFiles[4]),
        ]; 

        $manifestJSON = json_encode($manifestObject, JSON_PRETTY_PRINT);
        // \Drupal::logger('sec_webform')->warning(print_r($manifestJSON, TRUE));
        //write this manifest to a text file
        $submissionPath = "private://webform/corp_fin_noaction/" . $webform_submission->id();
        /** @var \Drupal\Core\File\FileSystemInterface $file_system */
        $file_system = \Drupal::service('file_system');

        $file_system->prepareDirectory($submissionPath, FileSystemInterface::CREATE_DIRECTORY | FileSystemInterface::MODIFY_PERMISSIONS);
        $fileLocation = $submissionPath . DIRECTORY_SEPARATOR . 'manifest.txt';
        if (file_put_contents($fileLocation, $manifestJSON)) {

          if (class_exists('\ZipArchive')) {
      
              $zipFileName = $file_system->getTempDirectory().DIRECTORY_SEPARATOR.$webform_submission->id().".zip";
              $zipBaseName = basename($zipFileName);
              $zip = new \ZipArchive();
              if($zip -> open($zipFileName, ZipArchive::CREATE | ZipArchive::OVERWRITE) === true) {
                // Store the path into the variable
                $zipPath = $file_system->realpath("private://")."/webform/corp_fin_noaction/".$webform_submission->id()."/";
                $zipBaseName = basename($zipFileName);
                $dir = opendir($zipPath);
                while($file = readdir($dir)) {            
                  if(is_file($zipPath.$file)) {
                      $zip -> addFile($zipPath.$file, $file);
                  }
                }
                $zip ->close();
                try {
                  $body = Psr7\Utils::tryFopen($zipFileName, 'r');
                  $response = \Drupal::httpClient()->post(
                      $wtsApiUrl, [
                        'headers' => [
                          'Content-Type' => 'application/zip',
                          'Content-Length' => filesize($zipFileName),
                          'API-KEY' => $wtsApiKey,
                          'Appian-Document-Name' => $zipBaseName
                        ],
                        'body' => $body,
                        'connect_timeout' => 1,
                        'timeout' => 30
                      ]
                  );
                  if ($response->getStatusCode() == 200) {
                      \Drupal::logger('sec_webform')->info("Successfully submitted webform #".$webform_submission->id()." to WTS.");             
                  }
                } catch (ClientException $client_exception) {
                  \Drupal::logger('sec_webform')->error(print_r($client_exception->getMessage(), true));
                  $this->handleError($webform_submission);
                } catch (RequestException $request_exception) {
                  \Drupal::logger('sec_webform')->error(print_r($request_exception->getMessage(), true));
                  $this->handleError($webform_submission);
                } catch(GuzzleException $other_exception) {
                  \Drupal::logger('sec_webform')->error(print_r($other_exception->getMessage(), true));
                  $this->handleError($webform_submission);
                } catch (ConnectException $connect_exception) {
                  \Drupal::logger('sec_webform')->error(print_r($connect_exception->getMessage(), true));
                  $this->handleError($webform_submission);
                } catch (Exception $e) {
                  \Drupal::logger('sec_webform')->error(print_r($e->getMessage(), true));
                  $this->handleError($webform_submission);
                }
            } else {
              \Drupal::logger('sec_webform')->error("Unable to create " . $zipFileName);
            }
          }
        }
    }

    /***
     * Retrieves a filename based on an $fid 
     */
    function getFileName($fid)
    {
        if (!empty($fid)) {
            $tmpFile = File::load($fid);
            if (!empty($tmpFile)) {
                // \Drupal::logger('sec_webform')->warning("filename for " .$fid . " is ". $tmpFile->getFilename());
                return $tmpFile->getFilename();
            }
        }
        return null;
    }

    /**
     * Handle error by logging and display debugging and/or exception message.
     *
     * @param WebformSubmissionInterface webform_submission
     *   webform_submission that failed
     */
    protected function handleError(WebformSubmissionInterface $webform_submission)
    {
        \Drupal::logger('sec_webform')->error("Error submitting webform #".$webform_submission->id()." to WTS. Deleting submission and redirecting user back to form.");

        //blank out the user email to prevent outgoing messages
        $webform_submission->setElementData("your_email_address", "");
    
        //get the submission url to kick user back
        $sourceUrl = $webform_submission->getSourceUrl()->toString()."?msg=fail";
        //delete this webform to prevent issues with resubmitting
        $webform_submission->delete();


        //send user back to submission url
        $response = new TrustedRedirectResponse($sourceUrl);
        $response->send();
    }
}