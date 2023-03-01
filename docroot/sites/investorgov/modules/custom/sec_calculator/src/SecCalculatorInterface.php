<?php

namespace Drupal\sec_calculator;

use Drupal\Component\Plugin\PluginInspectionInterface;

/**
 * Defines an interface for calculator plugins.
 */
interface SecCalculatorInterface extends PluginInspectionInterface {

  /**
   * Return the name of the calculator.
   *
   * @return string
   *   Name of the calculator.
   */
  public function getName();

  /**
   * Return the form.
   *
   * @return array
   *   A Drupal form array.
   */
  public function getForm();

}
