<?php

/**
 * @file
 * Definition of Drupal\investor_view_filter_plugin\Plugin\views\filter\InvestorYearFilter.
 */

namespace Drupal\investor_build\Plugin\views\filter;

use Drupal\views\Plugin\views\display\DisplayPluginBase;
use Drupal\views\Plugin\views\filter\FilterPluginBase;
use Drupal\views\ViewExecutable;
use Drupal\Core\Form\FormStateInterface;

/**
 * Filters by given list of Year options.
 *
 * @ingroup views_filter_handlers
 *
 * @ViewsFilter("investor_year_filter")
 */
class InvestorYearFilter extends FilterPluginBase
{

    /**
   * {@inheritdoc}
   */
    public function init(ViewExecutable $view, DisplayPluginBase $display, array &$options = null)
    {
        parent::init($view, $display, $options);
        $this->valueTitle = t('Allowed year values');
        $this->definition['options callback'] = [$this, 'generateOptions'];
    }

  /**
   * {@inheritdoc}
   */
  public function defineOptions() {
    $options = parent::defineOptions();

    $options['investor_build_end_year'] = $options['investor_build_start_year'] = [
      'default' => date("Y")
    ];

    return $options;
  }

  /**
   * {@inheritdoc}
   */
  public function buildOptionsForm(&$form, FormStateInterface $form_state) {
    $form['investor_build_start_year'] = [
      '#type' => 'textfield',
      '#title' => 'Start Year',
      '#default_value' => $this->options['investor_build_start_year'],
    ];
    $form['investor_build_end_year'] = [
      '#type' => 'textfield',
      '#title' => 'End Year',
      '#default_value' => $this->options['investor_build_end_year'],
    ];

    parent::buildOptionsForm($form, $form_state);
  }

  /**
   * {@inheritdoc}
   */
  public function submitOptionsForm(&$form, FormStateInterface $form_state) {
    $this->options['investor_build_start_year'] = $form_state->getValue('investor_build_start_year');
    $this->options['investor_build_end_year'] = $form_state->getValue('investor_build_end_year');
  }

  /**
   * {@inheritdoc}
   */
  public function acceptExposedInput($input) {
    return TRUE;
  }

  public function canExpose() {
    return TRUE;
  }

  /**
   * {@inheritdoc}
   */
  public function buildExposedForm(&$form, FormStateInterface $form_state)
  {
    if ($this->options['exposed']) {
      $values = $form_state->getUserInput();
      $endYear = $startYear = $defaultYear = date("Y");
      $selectedYear = $values['year'] ?: '_none';
      if (isset($this->options['investor_build_start_year']) && is_numeric($this->options['investor_build_start_year'])) {
        $startYear = $this->options['investor_build_start_year'];
      }
      else if (isset($this->options['investor_build_start_year']) && is_string($this->options['investor_build_start_year'])) {
        $date = new \DateTime($this->options['investor_build_start_year']);
        $startYear = $date->format("Y");
      }
      if (isset($this->options['investor_build_end_year']) && is_numeric($this->options['investor_build_end_year'])) {
        $endYear = $this->options['investor_build_end_year'];
      }
      else if (isset($this->options['investor_build_end_year']) && is_string($this->options['investor_build_end_year'])) {
        $date = new \DateTime($this->options['investor_build_end_year']);
        $endYear = $date->format("Y");
      }
      $yearOptions = ['_none' => 'All'];
      foreach (range($startYear, $endYear) as $year) {
        $yearOptions[$year] = $year;
      }

      $form['year'] = [
        '#type' => 'select',
        '#title' => 'Year',
        '#options' => $yearOptions,
        '#default_value' => $selectedYear,
      ];
    }
  }
    /**
   * Override the query so that no filtering takes place if the user doesn't
   * select any options.
   */
    public function query()
    {
      $values = $this->view->getExposedInput();
      if (isset($values['year']) && is_numeric($values['year'])) {
        $this->query->addWhereExpression(
          0, 'YEAR(node__field_date.field_date_value) = :year',
          [':year' => $values['year']]
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
}
