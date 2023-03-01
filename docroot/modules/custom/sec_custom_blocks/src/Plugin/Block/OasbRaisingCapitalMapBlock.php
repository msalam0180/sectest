<?php

/**
 * @file
 * Contains \src\Plugin\Block\OasbRaisingCapitalMapBlock.
 */

namespace Drupal\sec_custom_blocks\Plugin\Block;

use Drupal\Core\Block\BlockBase;

/**
 * Provides a 'OASB Capital Raising Map' block.
 *
 * @Block(
 *   id = "oasb_raising_capital_map_block",
 *   admin_label = @Translation("OASB Capital Raising Map"),
 *
 * )
 */
class OasbRaisingCapitalMapBlock extends BlockBase {
  /**
   * {@inheritdoc}
   */
  public function build() {
  // do something
    return array(
      '#theme' => 'raising_capital_map',
      '#attached' => [
        'library' => [
          'sec_custom_blocks/oasb_raising_capital_map',
        ],
      ],
    );
  }
}
