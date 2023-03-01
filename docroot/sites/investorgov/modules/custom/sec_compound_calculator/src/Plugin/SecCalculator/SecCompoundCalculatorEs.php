<?php

namespace Drupal\sec_compound_calculator\Plugin\SecCalculator;

use Drupal\sec_calculator\SecCalculatorBase;

/**
 * Provides a calculator in Spanish to compute compound interest.
 *
 * @SecCalculator(
 *   id = "sec_compound_calculator_spanish",
 *   name = @Translation("SEC Spanish Compound Interest Calculator"),
 * )
 */
class SecCompoundCalculatorEs extends SecCalculatorBase {

  /**
   * Get the form.
   */
  public function getForm() {
    return \Drupal::formBuilder()->getForm('Drupal\sec_compound_calculator\Form\CompoundCalculatorFormEs');
  }

}
