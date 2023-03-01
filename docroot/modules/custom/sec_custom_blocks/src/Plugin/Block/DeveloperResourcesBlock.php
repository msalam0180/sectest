<?php

/**
 * @file
 * Contains \src\Plugin\Block\DeveloperResourcesBlock.
 */

namespace Drupal\sec_custom_blocks\Plugin\Block;

use Drupal\Core\Block\BlockBase;

/**
 * Provides a Developer Resources Block.
 *
 * @Block(
 *   id = "developer_resources_block",
 *   admin_label = @Translation("Developer Resources"),
 * )
 */

class DeveloperResourcesBlock extends BlockBase
{

    /**
     * {@inheritdoc}
     */
    public function build() 
    {
        $markup = '<div class="developer">
          <h3>Developer Resources</h3>
          <p>Check out updates on the SEC open data program, including best practices that
          make it more efficient to download data.</p>
          <p class="xbrl-link-box"><a href="/developer">View Developer Resources</a></p>
        </div>';
        return [
            '#type' => 'markup',
            '#markup' => $markup,
            '#theme' => 'secgov',
        ];
    }

}
