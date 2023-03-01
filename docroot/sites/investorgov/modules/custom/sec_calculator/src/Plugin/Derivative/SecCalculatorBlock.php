<?php

namespace Drupal\sec_calculator\Plugin\Derivative;

use Drupal\Component\Plugin\Derivative\DeriverBase;
use Drupal\Core\Plugin\Discovery\ContainerDeriverInterface;
use Symfony\Component\DependencyInjection\ContainerInterface;

/**
 * Provides block plugin definitions for calculator blocks.
 *
 * @see \Drupal\sec_calculator\Plugin\Block\SecCalculatorBlock
 */
class SecCalculatorBlock extends DeriverBase implements ContainerDeriverInterface {

  /**
   * {@inheritdoc}
   */
  public static function create(ContainerInterface $container, $base_plugin_id) {
    return new static();
  }

  /**
   * {@inheritdoc}
   */
  public function getDerivativeDefinitions($base_plugin_definition) {

    // Get a list of available calculator plugins.
    $type = \Drupal::service('plugin.manager.sec_calculator');
    $calculators = $type->getDefinitions();

    foreach ($calculators as $id => $calculator) {
      $this->derivatives[$id] = $base_plugin_definition;
      $this->derivatives[$id]['admin_label'] = $calculator['name']->render();
      $this->derivatives[$id]['category'] = 'calculator';
    }
    return $this->derivatives;

  }

}
