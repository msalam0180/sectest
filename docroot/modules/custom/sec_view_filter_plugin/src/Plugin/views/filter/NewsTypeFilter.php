<?php

namespace Drupal\sec_view_filter_plugin\Plugin\views\filter;


use Drupal\views\Plugin\views\display\DisplayPluginBase;
use Drupal\views\Plugin\views\filter\InOperator;
use Drupal\views\ViewExecutable;

/**
 * Filters by given list of NewsTypeFilter options.
 *
 * @ingroup views_filter_handlers
 *
 * @ViewsFilter("sec_newsType_filter")
 */
class NewsTypeFilter extends InOperator
{

    /**
   * NewsTypeFilter constructor.
   */


    public function init(ViewExecutable $view, DisplayPluginBase $display, array &$options = null) 
    {
        parent::init($view, $display, $options);
        $this->valueTitle = $this->t("Allowed News-Type options.");
        $this->definition['options callback'] = [$this,'getNewsTypeList'];
    }
    /**
   * Override the query so that no filtering takes place if the user doesn't
   * select any options.
   */
    public function query() 
    {
        if (!empty($this->value)) {
            $this->query->addWhereExpression( 
                0, 'node_field_data_node__field_news_type_news.title = :type',
                [':type' => $this->value[0]]     
            );
        }
    }

    /**
   * Skip validation if no options have been chosen so we can use it as a
   * non-filter.
   */
    public function validate() 
    {
        if (!empty($this->value)) {
            parent::validate();
        }
    }
    /**
   * @return array of news_type list;
   */
    public function getNewsTypeList() 
    {
        $option = [];
        $connection = \Drupal::database();
        $results = $connection->select('node_field_data', 'nd')
            ->fields('nd', ['title'])
            ->condition('type', 'news_type')
            ->orderBy('title')->execute()->fetchAll();
        foreach ($results as $result) {
            $option[$result->title] = $result->title;
        }
        return $option;
    }
}