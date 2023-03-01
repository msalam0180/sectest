<?php

/**
 * @file
 * Contains \src\Plugin\Block\DigitalGovGlobalSearchBlock.
 */

namespace Drupal\sec_custom_blocks\Plugin\Block;

use Drupal\Core\Block\BlockBase;

/**
 * Provides a 'DigitalGov Global Search' block.
 *
 * @Block(
 *   id = "digitalgov_global_search_block",
 *   admin_label = @Translation("DigitalGov Global Search"),
 *
 * )
 */
class DigitalGovGlobalSearchBlock extends BlockBase {
  /**
   * {@inheritdoc}
   */
  public function build() {
  // do something
    return array(
      '#theme' => 'digitalgov_global_search',
      '#attached' => [
        'library' => [
          'sec_custom_blocks/digitalgov_global_search',
        ],
      ],
    );
  }
}
