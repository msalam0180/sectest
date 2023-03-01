<?php

namespace Drupal\sec_iapd_widget\Plugin\Block;

use Drupal\Core\Block\BlockBase;

/**
 * Provides the IAPD Widget Block.
 *
 * @Block(
 *   id = "iapd_widget_block",
 *   admin_label = @Translation("IAPD Widget Block"),
 *   category = @Translation("Investor"),
 * )
 */
class IapdWidgetBlock extends BlockBase {

  /**
   * {@inheritdoc}
   */
  public function build() {
    $block = [
      '#markup' => '<div id="sec-root"></div>',
      '#attached' => [
        // Default to test widget.
        'library' => ['sec_iapd_widget/widget_test'],
      ],

    ];
    // Only show prod widget if we're in production.
    if (isset($_ENV['AH_SITE_ENVIRONMENT']) && ($_ENV['AH_SITE_ENVIRONMENT'] == 'prod')) {
      $block['#attached']['library'] = 'sec_iapd_widget/widget';
    }

    return $block;
  }

}
