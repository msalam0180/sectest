<?php

namespace Drupal\sec_view_filter_plugin\Plugin\views\filter;


use Drupal\views\Plugin\views\display\DisplayPluginBase;
use Drupal\views\Plugin\views\filter\InOperator;
use Drupal\views\ViewExecutable;

/**
 * Filters by given list of ArticleType options.
 *
 * @ingroup views_filter_handlers
 *
 * @ViewsFilter("sec_articleType_filter")
 */
class ArticleTypeFilter extends InOperator
{

    /**
   * ArticleTypeFilter constructor.
   */


    public function init(ViewExecutable $view, DisplayPluginBase $display, array &$options = null) 
    {
        parent::init($view, $display, $options);
        $this->valueTitle = $this->t("Allowed Article Type options.");
        $this->definition['options callback'] = [$this,'getArticleList'];
    }
    /**
     * Override the query so that no filtering takes place if the user doesn't
     * select any options.
     */
    public function query() 
    {
        if (!empty($this->value)) {
            parent::query();
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
   * @return array of Article list;
   */
    public function getArticleList() 
    {
        $option = [];
        $connection = \Drupal::database();
        $results = $connection->select('node_field_data', 'nd')
            ->fields('nd', ['title'])
            ->condition('type', 'article_type')
            ->orderBy('title')->execute()->fetchAll();
        foreach ($results as $result) {
            $option[$result->title] = $result->title;
        }
        return $option;
    }
}