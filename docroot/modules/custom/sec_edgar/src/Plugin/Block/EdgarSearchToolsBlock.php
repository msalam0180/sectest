<?php

namespace Drupal\sec_edgar\Plugin\Block;

use Drupal\Core\Block\BlockBase;
use Drupal\Core\Form\FormStateInterface;

/**
 * Provides a 'Edgar Search Tools' Block.
 *
 * @Block(
 *   id = "edgar_search_tools_block",
 *   admin_label = @Translation("Edgar Search Tools block"),
 *   category = @Translation("SEC Custom Blocks"),
 * )
 */
class EdgarSearchToolsBlock extends BlockBase {

  /**
   * {@inerhitdoc}
   */
  public function blockForm($form, FormStateInterface $form_state) {
    $form_options = [
      'company_person_lookup' => 'Company and Person Lookup',
      'mutual_fund' => 'Mutual Fund Name',
      'fast_search_mutual' => 'Fast Search Mutual',
      'fast_search_variable' => 'Fast Search Variable',
      'variable_insurance_products' => 'Variable Insurance Products',
    ];

    $form['edgar_form'] = [
      '#type' => 'select',
      '#title' => $this->t('Edgar Form'),
      '#description' => $this->t('Select the Edgar form you want to use.'),
      '#options' => $form_options,
      '#default_value' => $this->configuration['edgar_forms'],
      '#required' => TRUE,
    ];

    $form['submission_url'] = [
      '#type' => 'textfield',
      '#title' => $this->t('Search Path'),
      '#default_value' => $this->configuration['submission_url'],
      '#description' => $this->t('This will be the search path where to submit the search (i.e. /search/path?q=abc).'),
      '#required' => TRUE,
    ];

    $form['description'] = [
      '#type' => 'textfield',
      '#title' => $this->t('Description'),
      '#default_value' => $this->configuration['description'],
      '#description' => $this->t('Enter search box description.'),
      '#required' => FALSE,
    ];

    return $form;
  }

  /**
   * {@inheritdoc}
   */
  public function blockSubmit($form, FormStateInterface $form_state) {
    $this->configuration['edgar_forms'] = $form_state->getValue('edgar_form');
    $this->configuration['submission_url'] = $form_state->getValue('submission_url');
    $this->configuration['description'] = $form_state->getValue('description');
  }

  /**
   * {@inheritdoc}
   */
  public function build() {
    switch ($this->configuration['edgar_forms']) {
      case 'company_person_lookup':
        $build = [
          '#theme' => 'sec_edgar_company_person_lookup',
          '#submission_url' => $this->configuration['submission_url'],
        ];
        break;
      default:
        return [
          '#theme' => 'sec_edgar_' . $this->configuration['edgar_forms'],
          '#title' => $this->configuration['label'],
          '#submission_url' => $this->configuration['submission_url'],
          '#description' => $this->configuration['description'],
          '#attached' => [
            'library' => [
              'sec_edgar/edgar-plugin',
            ],
          ],
        ];
    }

    return $build;
  }

}
