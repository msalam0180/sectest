<?php

namespace Drupal\sec_migration\Plugin\migrate\source;

use Drupal\migrate_source_csv\Plugin\migrate\source\CSV;
/**
 * Extracts Respondents See Also / Notes file urls
 *
 * @MigrateSource(
 *   id = "see_also",
 *   source_module = "sec_migration",
 * )
 */
class SeeAlso extends CSV {


  /**
   * {@inheritdoc}
   */
  public function initializeIterator() {
    $respondents = parent::initializeIterator();

    return $this->getYield($respondents);
  }

  /**
   * Prepares multiple rows per item
   *
   * @param \Generator $respondents
   *   The source respondents string object.
   *
   * @return \Generator
   *   A new row, one for each url in the source respondents string
   */
  public function getYield(\Generator $respondents) {
    foreach ($respondents as $row) {
      $urls = explode(")", $row['respondents']);
      foreach($urls as $url) {
        if (str_contains($url, 'http') || str_contains($url, 'public://')) {
          $regex = "/(\( Note:?|PDF| ;| ,|Finality|^ ?and|Final|Complaint:|\( Court|See also:?) (.*) \((http.+[^$]|public:.+[^$])/i";
          preg_match($regex, $url, $matches);
          if (!empty($matches)) {

            if (str_contains($matches[3], "http") || str_contains($matches[3], "public://")) {
              $url = trim($matches[3]);
              $label = trim($matches[2]);
              if ($label == "version" && $matches[1] == "PDF") $label = "PDF version";
              if ($label == "Order" && $matches[1] == "Finality") $label = "Finality Order";
              if ($label == "of Appeals Opinion" && $matches[1] == "( Court") $label = "Court of Appeals Opinion";
              if ($matches[1] == "Final") $label= $matches[1] . " " . $matches[2];
              if ($matches[1] == "Complaint:") $label = $matches[1] . " " . $matches[2];
              if (str_contains($label, "; Finality Order") ) $label = "Finality Order";
              $new_row = $row;
              $new_row["id"] = $url;
              $new_row["url"] = $url;
              $new_row["title"] = $label;
              yield ($new_row);
            }
          }
        }

      }
    }
  }


  /**
   * {@inheritdoc}
   */
  public function getIds() {
    return [
      'id' => [
        'type' => 'string',
        'alias' => 'id',
      ]
    ];
  }
}
