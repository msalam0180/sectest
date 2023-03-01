<?php

namespace Drupal\investor_migrate\Plugin\migrate\source;

use Drupal\migrate\Row;
use Drupal\node\Plugin\migrate\source\d7\Node as D7_Node;

/**
 * Drupal 7 page node source plugin.
 *
 * @MigrateSource(
 *  id = "investor_node",
 *  source_provider = "node"
 * )
 */
class InvestorNode extends D7_Node {
  /**
     * {@inheritdoc}
     */
    public function fields() {
      return ['alias' => $this->t('Path alias')] + parent::fields();
    }

    /**
     * {@inheritdoc}
     */
    public function query() {
      $query = $this->select('node_revision', 'nr');
      $query->innerJoin('node', 'n', static::JOIN);

      $query->fields('n', [
        'nid',
        'type',
        'language',
        'status',
        'created',
        'changed',
        'comment',
        'promote',
        'sticky',
        'tnid',
        'translate',
      ])
      ->fields('nr', [
        'vid',
        'title',
        'log',
        'timestamp',
      ]);
      $query->addField('n', 'uid', 'node_uid');
      $query->addField('nr', 'uid', 'revision_uid');
      if (isset($this->configuration['node_type'])) {
        $query->condition('n.type', $this->configuration['node_type']);
      }
      return $query;
    }


  /**
   * {@inheritdoc}
   */
  public function prepareRow(Row $row) {
      // Include path alias.
      $nid = $row->getSourceProperty('nid');
      $query = $this->select('url_alias', 'ua')
        ->fields('ua', ['alias']);
      $query->condition('ua.source', 'node/' . $nid);
      $alias = $query->execute()->fetchField();
      if (!empty($alias)) {
        $row->setSourceProperty('alias', '/' . $alias);
      }
      return parent::prepareRow($row);
    }

}
