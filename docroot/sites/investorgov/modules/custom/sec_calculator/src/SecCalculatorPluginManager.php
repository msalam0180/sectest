<?php

namespace Drupal\sec_calculator;

use Drupal\Core\Plugin\DefaultPluginManager;
use Drupal\Core\Cache\CacheBackendInterface;
use Drupal\Core\Extension\ModuleHandlerInterface;

/**
 * Calculator plugin manager.
 */
class SecCalculatorPluginManager extends DefaultPluginManager {

  /**
   * Constructs a Calculator object.
   *
   * @param \Traversable $namespaces
   *   An object that implements \Traversable which contains the root paths
   *   keyed by the corresponding namespace to look for plugin implementations.
   * @param \Drupal\Core\Cache\CacheBackendInterface $cache_backend
   *   Cache backend instance to use.
   * @param \Drupal\Core\Extension\ModuleHandlerInterface $module_handler
   *   The module handler to invoke the alter hook with.
   */
  public function __construct(\Traversable $namespaces, CacheBackendInterface $cache_backend, ModuleHandlerInterface $module_handler) {
    parent::__construct('Plugin/SecCalculator', $namespaces, $module_handler, 'Drupal\sec_calculator\SecCalculatorInterface', 'Drupal\sec_calculator\Annotation\SecCalculator');

    $this->alterInfo('sec_calculator_info');
    $this->setCacheBackend($cache_backend, 'sec_calculator');
  }

}
