<?php

/**
 * @file
 * Contains \src\Plugin\Block\SecMissionBlock.
 */

namespace Drupal\sec_custom_blocks\Plugin\Block;

use Drupal\Core\Block\BlockBase;

/**
 * Provides a Adminstrative Proceedings Button Block.
 *
 * @Block(
 *   id = "administrative_proceedings_button_block",
 *   admin_label = @Translation("Administrative Proceedings Button"),
 * )
 */

class AdministrativeProceedingsButtonBlock extends BlockBase
{

    /**
     * {@inheritdoc}
     */
    public function build() {
        $markup = '<div class="button-box"><a href="/litigation/apdocuments.shtml"><span class="svg-icon svg-icon-lg">o</span> <span class="description">Administrative<br />
Proceeding<br />Documents</span></a></div>';
        return [
            '#type' => 'markup',
            '#markup' => $markup,
            '#theme' => 'secgov',
        ];
    }

}
