<?php

namespace Drupal\sec_savings_calculator\Plugin\SecCalculator;

use Drupal\sec_calculator\SecCalculatorBase;

/**
 * Provides a calculator to compute savings goals.
 *
 * @SecCalculator(
 *   id = "sec_savings_calculator",
 *   name = @Translation("SEC Savings Goal Calculator"),
 * )
 */
class SecSavingsCalculator extends SecCalculatorBase {

  /**
   * Get the form.
   */
  public function getForm() {
    return \Drupal::formBuilder()->getForm('Drupal\sec_savings_calculator\Form\SavingsCalculatorForm');
  }

}
