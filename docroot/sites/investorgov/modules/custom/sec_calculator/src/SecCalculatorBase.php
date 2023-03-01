<?php

namespace Drupal\sec_calculator;

use Drupal\Component\Plugin\PluginBase;

/**
 * SEC Calculator base class.
 */
class SecCalculatorBase extends PluginBase implements SecCalculatorInterface {

  /**
   * Get the name of the calculator.
   */
  public function getName() {
    return $this->pluginDefinition['name'];
  }

  /**
   * Get the calculator form.
   */
  public function getForm() {
  }

}
