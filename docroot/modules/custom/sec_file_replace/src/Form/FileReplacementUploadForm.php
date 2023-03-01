<?php

namespace Drupal\sec_file_replace\Form;

use Drupal\Core\File\FileSystemInterface;
use Drupal\Core\Form\FormStateInterface;

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\RedirectResponse;

use Drupal\Component\Render\FormattableMarkup;

use GuzzleHttp\Client;
use GuzzleHttp\Exception\ClientException;
use GuzzleHttp\Exception\ServerException;

/**
 * Class FileReplacementUploadForm.
 *
 * @package Drupal\sec_file_replace\Form
 */
class FileReplacementUploadForm extends SECReplaceFormBase
{


    /**
   * {@inheritdoc}
   */
    public function getFormId() 
    {
        return 'upload_form';
    }

    /**
   * {@inheritdoc}
   */
    public function buildForm(array $form, FormStateInterface $form_state) 
    {

        $form = parent::buildForm($form, $form_state);
        $node = $this->store->get('node');
        $nid = $node->nid->value;
        // if the node is null, the user should be redirected to the search screen.
        if (is_null($node)) {
            // TODO: get target from route rather than hardcoding here
            $response = new RedirectResponse('/admin/config/media/file-system/replace/search');
            $response->send();
        } else {
            $file_name = $this->store->get('file_name');
            $nid = $node->nid->value;
            $title = $node->title->value;
            $display_title = $node->field_display_title->value;
            $update_title = 'Update Last Updated Date';
            $update_head_title = 'Last Updated';
            $update_message = 'Check this to update the override modified date field.';
            if ($node->hasField('field_date') == 1) {
                $field_date = $node->field_date->value;
            } elseif ($node->hasField('field_publish_date') == 1) {
                $field_date = $node->field_publish_date->value;
                $update_title = 'Update Publish Date';
                $update_head_title = 'Publish Date';
                $update_message = 'Check this to update the publish date field.';
            }
            $markup = <<<HTML
        <table>
          <thead>
            <tr>
              <th>File</th>
              <th>Title</th>
              <th>Display Title</th>
              <th>$update_head_title</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>$file_name</td>
              <td><a href="/node/$nid/edit" target="_blank">$title</a></td>
              <td>$display_title</td>
              <td>$field_date</td>
            </tr>
          </tbody>
        </table>
HTML;

            $form['info'] = [
            '#type' => 'container',
            '#markup' => $markup,
            ];

            $form['update_date'] = [
            '#type' => 'checkbox',
            '#title' => $update_title,
            ];

      $form['update_info_text'] = [
        '#type' => 'html_tag',
        '#tag' => 'p',
        '#value' => $this->t($update_message),
        '#attributes' => [
          'class' => 'update-info-text',
        ],
      ];

            $form['file_upload'] = [
            '#type' => 'file',
            '#title' => $this->t('Select a file to upload'),
            ];

            $form['clear_cache'] = [
            '#type' => 'checkbox',
            '#title' => 'Clear Varnish Cache',
            ];

            return $form;
        }

    }

    /**
    * {@inheritdoc}
    */
    public function validateForm(array &$form, FormStateInterface $form_state) 
    {

        $node = $this->store->get('node');
        if ($node->hasField('field_file_upload') == 1) {
            $dest_filename = basename($node->field_file_upload->entity->getFileUri());
        } elseif ($node->hasField('field_data_dist_upload') == 1) {
            $dest_filename = basename($node->field_data_dist_upload->entity->getFileUri());
        } else {
            $form_state->setErrorByName('file_upload', $this->t('The file replacement utility is not configured to update files for this content type.'));
            return;
        }
        $request = Request::createFromGlobals();
        if (is_null($request->files->get('files')['file_upload'])) {
            $form_state->setErrorByName('file_upload', $this->t('You must select a file to upload.'));
        } elseif ($dest_filename != $request->files->get('files')['file_upload']->getClientOriginalName()) {
            $form_state->setErrorByName('file_upload', $this->t('The uploaded file must have the same name as the file being replaced.'));
        }
    }

    /**
   * {@inheritdoc}
   */
  public function submitForm(array &$form, FormStateInterface $form_state) {
    // Get filename for email and logging
    $node = $this->store->get('node');
    if ($node->hasField('field_file_upload') == 1) {
      $file_name = basename($node->field_file_upload->entity->getFileUri());
    } elseif ($node->hasField('field_data_dist_upload') == 1) {
      $file_name = basename($node->field_data_dist_upload->entity->getFileUri());
    }

    // If user checked update publish date checkbox, update the node
    if ($form_state->getValue('update_date') == 1) {
      $this->updateOverrideModified();
    }
    // replace the file
    $replace = $this->replaceFile();
    if ($replace === false) {
      $form_state->setErrorByName('file_upload', $this->t('An error occurred uploading this file. Please reach out to <a href="mailto:drupalsupport@sec.gov">Drupal Support</a> for assistance.'));
    } else {
      $this->messenger()->addStatus(t('The file has been successfully replaced.'));
      if ($form_state->getValue('clear_cache') == 1 && \Drupal::request()->getHost() != 'secgov.dev.dd') {
        $no_errors = true;
        // Derive Acquia Cloud environment from Drupal host
        $site = explode('.', \Drupal::request()->getHost())[0];
        if ($site == "secgov") {
          $env = 'prod';
        } else {
          $env = str_replace('secgov', '', $site);
        }
        // Get Acquia Cloud API credentials from config
        $config = \Drupal::config('sec_file_replace.settings');
        $user = $config->get('acquia_cloud_api_user');
        $key = $config->get('acquia_cloud_api_key');
        // Issue Acquia Cloud API call to get domains to be deleted from Varnish
        $client = new Client(['base_uri' => 'https://cloudapi.acquia.com']);
        try {
          $response = $client->request(
            'GET',
            '/v1/sites/prod:secgov/envs/' . $env . '/domains.json',
            ['auth' => [$user, $key]]
          );
        }
        catch (ServerException $e) {
          \Drupal::logger('Static File Replacement')->error(
            'A 500-level error occured getting domains for %env: %message',
            ['%env' => $env, '%message' => Psr7\str($e->getResponse())]
          );
          $no_errors = false;
        }
        if ($response->getStatusCode() === 200) {
          $domains = json_decode($response->getBody());
          foreach ($domains as $domain) {
            try {
              $response = $client->request(
                'DELETE',
                '/v1/sites/prod:secgov/envs/' . $env . '/domains/' . $domain->name . '/cache.json',
                ['auth' => [$user, $key]]
              );
              if ($response->getStatusCode() === 200) {
                \Drupal::logger('Static File Replacement')->notice(
                  'Varnish cache cleared (%domain)',
                  ['%domain' => $domain->name]
                );
              } else {
                \Drupal::logger('Static File Replacement')->error(
                  'Could not clear Varnish cache: %message',
                  ['%message' => $response->getBody()]
                );
                $no_errors = false;
              }
            }
            catch (ClientException $e) {
              \Drupal::logger('Static File Replacement')->error(
                'A 400-level error occured for domain %domain: %message',
                ['%domain' => $domain->name, '%message' => Psr7\str($e->getResponse())]
              );
              $no_errors = false;
            }
            catch (ServerException $e) {
              \Drupal::logger('Static File Replacement')->error(
                'A 500-level error occured for domain %domain: %message',
                ['%domain' => $domain->name, '%message' => Psr7\str($e->getResponse())]
              );
              $no_errors = false;
            }
          }
        } else {
          \Drupal::logger('Static File Replacement')->error(
            'Could not retrieve site domains: :message',
            [':message' => $response->getBody()]
          );
          $no_errors = false;
        }

        // If user checked update publish date checkbox, update the node
        if ($form_state->getValue('update_date') == 1) {
            $this->updateOverrideModified();
        }
        // replace the file
        $replace = $this->replaceFile();
        if ($replace === false) {
            $form_state->setErrorByName('file_upload', $this->t('An error occurred uploading this file. Please reach out to <a href="mailto:drupalsupport@sec.gov">Drupal Support</a> for assistance.'));
        } else {
            $this->messenger()->addStatus(t('The file has been successfully replaced.'));
            if ($form_state->getValue('clear_cache') == 1 && \Drupal::request()->getHost() != 'secgov.dev.dd') {
                $no_errors = true;
                // Derive Acquia Cloud environment from Drupal host
                $site = explode('.', \Drupal::request()->getHost())[0];
                if ($site == "secgov") {
                    $env = 'prod';
                } else {
                    $env = str_replace('secgov', '', $site);
                }
                // Get Acquia Cloud API credentials from config
                $config = \Drupal::config('sec_file_replace.settings');
                $user = $config->get('acquia_cloud_api_user');
                $key = $config->get('acquia_cloud_api_key');
                // Issue Acquia Cloud API call to get domains to be deleted from Varnish
                $client = new Client(['base_uri' => 'https://cloudapi.acquia.com']);
                try {
                    $response = $client->request(
                        'GET',
                        '/v1/sites/prod:secgov/envs/' . $env . '/domains.json',
                        ['auth' => [$user, $key]]
                    );
                }
                catch (ServerException $e) {
                    \Drupal::logger('Static File Replacement')->error(
                        'A 500-level error occured getting domains for %env: %message',
                        array('%env' => $env, '%message' => Psr7\str($e->getResponse()))
                    );
                    $no_errors = false;
                }
                if ($response->getStatusCode() === 200) {
                    $domains = json_decode($response->getBody());
                    foreach ($domains as $domain) {
                        try {
                            $response = $client->request(
                                'DELETE',
                                '/v1/sites/prod:secgov/envs/' . $env . '/domains/' . $domain->name . '/cache.json',
                                ['auth' => [$user, $key]]
                            );
                            if ($response->getStatusCode() === 200) {
                                          \Drupal::logger('Static File Replacement')->notice(
                                              'Varnish cache cleared (%domain)',
                                              array('%domain' => $domain->name)
                                          );
                            } else {
                                          \Drupal::logger('Static File Replacement')->error(
                                              'Could not clear Varnish cache: %message',
                                              array('%message' => $response->getBody())
                                          );
                                          $no_errors = false;
                            }
                        }
                        catch (ClientException $e) {
                            \Drupal::logger('Static File Replacement')->error(
                                'A 400-level error occured for domain %domain: %message',
                                array('%domain' => $domain->name, '%message' => Psr7\str($e->getResponse()))
                            );
                            $no_errors = false;
                        }
                        catch (ServerException $e) {
                            \Drupal::logger('Static File Replacement')->error(
                                'A 500-level error occured for domain %domain: %message',
                                array('%domain' => $domain->name, '%message' => Psr7\str($e->getResponse()))
                            );
                            $no_errors = false;
                        }
                    }
                } else {
                    \Drupal::logger('Static File Replacement')->error(
                        'Could not retrieve site domains: :message',
                        array(':message' => $response->getBody())
                    );
                    $no_errors = false;
                }

                if ($no_errors) {
                    $this->messenger()->addStatus(t('Varnish cache has been cleared. <br \>The file should now be updated on SEC.gov.'));
                } else {
                    $this->messenger()->addError(t('There was a problem clearing Varnish cache. <br \>Please reach out to <a href="mailto:drupalsupport@sec.gov">Drupal Support</a> for assistance.'));
                }
            }
            $form_state->setRedirect('sec_file_replace.search');
        }
        \Drupal::logger('Static File Replacement')->notice(
            '%user updated %file',
            array('%user' => \Drupal::currentUser()->getAccountName(), '%file' => $file_name)
        );
    }
    \Drupal::logger('Static File Replacement')->notice(
      '%user updated %file',
      ['%user' => \Drupal::currentUser()->getAccountName(), '%file' => $file_name]
    );
  }
}
    /**
   * Replaces current file with uploaded file
   */
    protected function replaceFile() 
    {
        $validators = [
        'file_validate_extensions' => ["pdf csv xls txt zip doc json xml jpg jpeg gif png"],
        'file_validate_size' => [file_upload_max_size()],
        ];

        $node = $this->store->get('node');
        if ($node->hasField('field_file_upload') == 1) {
            $dest_dir = dirname($node->field_file_upload->entity->getFileUri());
        } elseif ($node->hasField('field_data_dist_upload') == 1) {
            $dest_dir = dirname($node->field_data_dist_upload->entity->getFileUri());
        }

        if ($dest_dir == 'public:') {
            $dest_dir .= '//';
        }

        $file = file_save_upload('file_upload', $validators, $dest_dir, null, FileSystemInterface::EXISTS_REPLACE);

        if ($file !== false) {
            $this->deleteStore();
        }
        return $file;
    }

    /**
   * Update field_date of node
   */
    protected function updateOverrideModified() 
    {
        $nid = intval($this->store->get('node')->nid->value);
        $node = \Drupal::entityTypeManager()
        ->getStorage('node')
        ->load($nid);
        if ($node->hasField('field_date') == 1) {
            $node->field_date->value = date('Y-m-d\TH:i:s');
        } elseif ($node->hasField('field_publish_date') == 1) {
            $node->field_publish_date->value = date('Y-m-d\TH:i:s');
        }
        $node->save();

    }

}
