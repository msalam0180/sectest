<?php

/**
 * @file
 * Definition of Drupal\sec_view_filter_plugin\Plugin\views\field\SecPublishedDateField.
 */

namespace Drupal\sec_view_filter_plugin\Plugin\views\field;

use Drupal\views\Plugin\views\field\FieldPluginBase;
use Drupal\views\ResultRow;

/**
 * Field handler to group the node by seasons.
 *
 * @ingroup views_field_handlers
 *
 * @ViewsField("sec_field_publish_date")
 */
class SecPublishedDateField extends FieldPluginBase
{

    /**
   * @{inheritdoc}
   */
    public function query() 
    {
        // Leave empty to avoid a query on this field.
    }
    /**
   * @{inheritdoc}
   */
    public function render(ResultRow $values) 
    {
        $node = $values->_entity;
        if (!empty($node->get('field_publish_date')->value)) {
            return \Drupal::service('date.formatter')->format(
                strtotime($node->get('field_publish_date')->value),
                'custom',
                'F Y'
            );
        }
    }
}
