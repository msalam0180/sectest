<?php

namespace Drupal\sec_data_distribution\Plugin\views\style;

use Drupal\node\Entity\Node;
use Drupal\rest\Plugin\views\style\Serializer;
use Drupal\taxonomy\Entity\Term;

/**
 * A style plugin for Project Open Data json data.
 *
 * @ingroup views_style_plugins
 *
 * @ViewsStyle(
 *   id = "open_data_serializer",
 *   title = @Translation("Open Data Serializer"),
 *   help = @Translation("Configurable row output for data exports."),
 *   display_types = {"data"}
 * )
 */
class OpenDataSerializer extends Serializer
{

    public function render()
    {
        $renderArray = [];
        $datasetArray = [];

        foreach ($this->view->result as $row_index => $row) {

            $this->view->row_index = $row_index;
            $datasetEntity = $row->_entity;
            $nid = $datasetEntity->nid->value;
            $divisionOffice = $datasetEntity->field_primary_division_office->entity->label();
            $beginDate = $datasetEntity->field_publish_date->value;
            $endDate = $datasetEntity->field_date->value;
            if (empty($endDate)) {
                $endDate = date("Y-m-d\TH:i:s", $datasetEntity->changed->value);
            }
            $dataDictionary = $datasetEntity->field_media_file_upload->entity->field_media_file->entity;
            // 			"mediaType" => $dataDistFile->getMimeType(),
            // 			"downloadURL" => file_create_url($dataDistFile->getFileUri()),
            //get this dataset's url path
            $options = ['absolute' => true];
            $url = \Drupal\Core\Url::fromRoute('entity.node.canonical', ['node' => $nid], $options);
            $url = $url->toString();


            $dataset = [];

            $dataset = [
              "@type" => "dcat:Dataset",
              "identifier" => "https://www.sec.gov/node/".$nid,
              "landingPage" => $url,
              "bureauCode" => ["449:00"],
              "programCode" => ["000:000"],
              "accessLevel" => "public",
              "temporal" => $beginDate ."Z/". $endDate ."Z",
              "license" => "http://www.usa.gov/publicdomain/label/1.0/",
              "title" => $datasetEntity->field_display_title->value,
              "publisher" => [
             "name" =>$divisionOffice,
             "subOrganizationOf" => [
               "name" => "U.S. Securities and Exchange Commission",
               "subOrganizationOf" => [
                 "name" => "U.S. Government"
               ]
             ]

              ],
            ];
            $modified = null;

            $distributionRows = [];
            //add distributions
            $distributionEntities = $this->findRelatedDistributions($nid);

            if (!empty($distributionEntities)) {
                foreach ($distributionEntities as $dataDist) {
                    $dataDistFile = $dataDist->field_data_dist_upload->entity;
                    $dataDistAccessUrl = $dataDist->field_access_url[0];
                    if ($dataDistFile && $dataDistAccessUrl) {
                        $dataDistRow = [
                          "@type" => "dcat:Distribution",
                          "title" => $dataDist->field_display_title->value,
                          "mediaType" => $dataDistFile->getMimeType(),
                          "downloadURL" => file_create_url($dataDistFile->getFileUri()),
                          "accessURL" => $dataDistAccessUrl->uri,

                        ];
                    } else if ($dataDistFile) {
                        $dataDistRow = [
                          "@type" => "dcat:Distribution",
                          "title" => $dataDist->field_display_title->value,
                          "mediaType" => $dataDistFile->getMimeType(),
                          "downloadURL" => file_create_url($dataDistFile->getFileUri())
                        ];
                    } else if ($dataDistAccessUrl) {
                        $dataDistRow = [
                          "@type" => "dcat:Distribution",
                          "title" => $dataDist->field_display_title->value,
                          "description" =>$dataDist->field_description_abstract->value,
                          "accessURL" => $dataDistAccessUrl->uri
                        ];
                    }

                    if (!empty($dataDist->field_description_abstract->value)) {
                        $dataDistRow["description"] = $dataDist->field_description_abstract->value;
                    }
                    $distributionRows[] = $dataDistRow;


                    //calculate a modified date from distribution files
                    if (!$modified || (strtotime($modified) < strtotime($dataDistFile->changed->value))) {
                        $modified = $dataDistFile->changed->value;
                    }

                }
            }


            if (!$modified) {
                $modified = $datasetEntity->changed->value;
            }
            $dataset["modified"] = date("Y-m-d\TH:i:s\Z", $modified);

            $keywordRows = [];
            //add distributions
            if (!empty($datasetEntity->field_tags)) {
                foreach ($datasetEntity->field_tags as $keywordEntity) {
                    $term = Term::load($keywordEntity->target_id);
                    $keywordRows[] = $term->getName();
                }
            }
            //add Data Dictionary describedBy and describedByType
            if ($dataDictionary) {
                      $dataset["describedBy"] = file_create_url($dataDictionary->getFileUri());
                      $dataset["describedByType"] = $dataDictionary->getMimeType();
            }

            if (!empty($datasetEntity->field_article_sub_type_secart->value)) {
                $dataset["theme"] = [$datasetEntity->field_article_sub_type_secart->value];
            }
            if (!empty($datasetEntity->field_accrual_periodicity->value)) {
                $dataset["accrualPeriodicity"] = $datasetEntity->field_accrual_periodicity->value;
            }
            if (!empty($datasetEntity->field_contact_name->value)) {
                $dataset["contactPoint"] = [    "fn" => $datasetEntity->field_contact_name->value,"hasEmail"=>"mailto:".$datasetEntity->field_contact_email->value];
            }
            if (!empty($distributionRows)) {
                $dataset["distribution"] = $distributionRows;
            }
            if (!empty($keywordRows)) {
                $dataset["keyword"] = $keywordRows;
            }
            if (!empty($datasetEntity->field_description_abstract->value)) {
                $dataset["description"] = $datasetEntity->field_description_abstract->value;
            }
            $datasetArray[] = $dataset;
        }

        $renderArray = [
          "@context" => "https://project-open-data.cio.gov/v1.1/schema/catalog.jsonld",
          "@id" => "https://www.sec.gov/data.json",
          "@type" => "dcat:Catalog",
          "conformsTo" => "https://project-open-data.cio.gov/v1.1/schema",
          "describedBy" => "https://project-open-data.cio.gov/v1.1/schema/catalog.json",
          "dataset" => $datasetArray
        ];
        unset($this->view->row_index);

        return json_encode($renderArray, JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT);
    }

    function findRelatedDistributions($datasetId)
    {
        $query = \Drupal::entityQuery('node')
        ->condition('type', 'data_distribution')
        ->condition('status', 1)
        ->condition('field_associated_dataset.target_id', $datasetId)
        ->sort('field_publish_date', 'DESC');
        $nids = $query->execute();

        if ($nids) {
            return Node::loadMultiple($nids);
        }

        return [];
    }
}
