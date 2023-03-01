<?php

namespace Drupal\investor_build\Plugin\Block;

use Drupal\Core\Block\BlockBase;
use Drupal\Core\Form\FormStateInterface;

/**
 * Provides a 'Edgar Search' Block.
 *
 * @Block(
 *   id = "edgar_search_form_block",
 *   admin_label = @Translation("Edgar Search block"),
 *   category = @Translation("Edgar Search"),
 * )
 */
class EdgarSearchBlock extends BlockBase {

  /**
   * {@inheritdoc}
   */
  public function build() {
    return [
      '#theme' => 'edgar_search_block',
      '#attached' => [
        'library' => [
          'investor_build/edgar-search',
        ],
      ],
    ];
  }

  /**
   * {@inheritdoc}
   */
  public function blockForm($form, FormStateInterface $form_state) {
    $form = parent::blockForm($form, $form_state);

    $config = $this->getConfiguration();

    $form['feature_block'] = [
      '#type' => 'checkbox',
      '#title' => $this->t('Feature Block'),
      '#default_value' => isset($config['feature_block']) ? $config['feature_block'] : 0,
    ];

    $form['width_factor'] = [
      '#type' => 'select',
      '#title' => $this->t('Width Factor'),
      '#default_value' => isset($config['width_factor']) ? $config['width_factor'] : '',
      '#options' => ['1' => '1x', '2' => '2x', '3' => '3x'],
    ];

    return $form;
  }

  /**
   * {@inheritdoc}
   */
  public function blockSubmit($form, FormStateInterface $form_state) {
    parent::blockSubmit($form, $form_state);
    $values = $form_state->getValues();
    $this->configuration['feature_block'] = $values['feature_block'];
    $this->configuration['width_factor'] = $values['width_factor'];
  }

}