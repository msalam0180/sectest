<?php

/**
 * @file
 * Contains \Drupal\sec_rmd_calculator\Plugin\SecCalculator\SecRmdCalculator.
 */

namespace Drupal\sec_rmd_calculator\Plugin\SecCalculator;

use Drupal\sec_calculator\SecCalculatorBase;

/**
 * Provides a calculator to estimate IRA/401(k) required minimum distribution.
 *
 * @SecCalculator(
 *   id = "sec_rmd_calculator",
 *   name = @Translation("SEC RMD Calculator"),
 * )
 */
class SecRmdCalculator extends SecCalculatorBase {

  public function getForm() {
    return $form = \Drupal::formBuilder()->getForm('Drupal\sec_rmd_calculator\Form\RmdCalculatorForm');
  }

}
