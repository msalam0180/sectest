<?php

namespace Drupal\sec_calculator\Plugin\Block;

use Drupal\Core\Block\BlockBase;

/**
 * Provides a block that contains an SEC calculator.
 *
 * @Block(
 *   id = "sec_calculator_block",
 *   admin_label = @Translation("SEC Calculator Block"),
 *   category = @Translation("Calculators"),
 *   deriver = "Drupal\sec_calculator\Plugin\Derivative\SecCalculatorBlock"
 * )
 */
class SecCalculatorBlock extends BlockBase {

  /**
   * {@inheritdoc}
   */
  public function build() {
    $block_id = $this->getDerivativeId();
    $manager = \Drupal::service('plugin.manager.sec_calculator');
    $calculator = $manager->createInstance($block_id, []);
    $form = $calculator->getForm();
    return $form;
  }

}
