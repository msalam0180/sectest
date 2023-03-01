<?php

namespace Drupal\sec_compound_calculator\Plugin\SecCalculator;

use Drupal\sec_calculator\SecCalculatorBase;

/**
 * Provides a calculator to compute compound interest.
 *
 * @SecCalculator(
 *   id = "sec_compound_calculator",
 *   name = @Translation("SEC Compound Interest Calculator"),
 * )
 */
class SecCompoundCalculator extends SecCalculatorBase {

  /**
   * Get the form.
   */
  public function getForm() {
    return \Drupal::formBuilder()->getForm('Drupal\sec_compound_calculator\Form\CompoundCalculatorForm');
  }

}
