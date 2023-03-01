<?php

namespace Drupal\sec_calculator\Annotation;

use Drupal\Component\Annotation\Plugin;

/**
 * Defines a calculator annotation object.
 *
 * Plugin Namespace: Plugin\sec_calculator\sec_calculator.
 *
 * @see \Drupal\sec_calculator\Plugin\SecCalculatorPluginManager
 * @see plugin_api
 *
 * @Annotation
 */
class SecCalculator extends Plugin {

  /**
   * The plugin ID.
   *
   * @var string
   */
  public $id;

  /**
   * The name of the calculator.
   *
   * @var \Drupal\Core\Annotation\Translation
   *
   * @ingroup plugin_translatable
   */
  public $name;

}
