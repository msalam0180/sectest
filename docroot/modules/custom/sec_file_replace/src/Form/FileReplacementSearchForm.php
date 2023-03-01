<?php

namespace Drupal\sec_file_replace\Form;

use Drupal\file\Entity\File;
use Drupal\Core\Form\FormStateInterface;

/**
 * Class FileReplacementForm.
 *
 * @package Drupal\sec_file_replace\Form
 */
class FileReplacementSearchForm extends SECReplaceFormBase
{


    /**
   * {@inheritdoc}
   */
    public function getFormId() 
    {
        return 'search_form';
    }

    /**
   * {@inheritdoc}
   */
    public function buildForm(array $form, FormStateInterface $form_state) 
    {

        $form = parent::buildForm($form, $form_state);

        $form['intro'] = [
        '#type' => 'container',
        '#markup' => '<h3>Search for content by file name</h3>',
        ];

        $form['file_name'] = [
        '#type' => 'textfield',
        '#title' => 'File name',
        '#required' => true,
        ];

        return $form;
    }

    /**
    * {@inheritdoc}
    */
    public function validateForm(array &$form, FormStateInterface $form_state) 
    {
        $node = $this->getNode($form_state->getValue('file_name'));
        if ($node === false) {
            $form_state->setErrorByName('file_name', $this->t('There is no content associated with this file.'));
        } else {
            $this->store->set('node', $node);
        }
    }

    /**
   * {@inheritdoc}
   */
    public function submitForm(array &$form, FormStateInterface $form_state) 
    {

        $this->store->set('file_name', $form_state->getValue('file_name'));
        $form_state->setRedirect('sec_file_replace.upload');

    }

    /**
   * Helper method that searches nodes based on file name
   */
    protected function getNode($file_name) 
    {
        $sql = <<<SQL
      SELECT f.field_file_upload_target_id fid,
             n.nid
        FROM node n,
             node__field_file_upload f
       WHERE f.entity_id = n.nid
      UNION
      SELECT f.field_data_dist_upload_target_id,
             n.nid
       FROM node n,
            node__field_data_dist_upload f
       WHERE f.entity_id = n.nid;
SQL;

        $db_conn = \Drupal::database();
        $query = $db_conn->query($sql);
        $results = $query->fetchAll();
        foreach ($results as $row) {
            $file = File::load($row->fid);
            if ($file->getFileName() === $file_name) {
                $node = \Drupal::entityTypeManager()->getStorage('node')->load(intval($row->nid));
                break;
            }
        }
        if (!is_null($node)) {
            return $node;
        } else {
            return false;
        }
    }

}
