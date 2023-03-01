<?php

/**
 * @file
 * Contains \src\Plugin\Block\SecMissionBlock.
 */

namespace Drupal\sec_custom_blocks\Plugin\Block;

use Drupal\Core\Block\BlockBase;

/**
 * Provides a Submit a Tip Button Block.
 *
 * @Block(
 *   id = "submit_a_tip_button_block",
 *   admin_label = @Translation("Submit a Tip Button"),
 * )
 */

class SubmitATipButtonBlock extends BlockBase
{

    /**
     * {@inheritdoc}
     */
    public function build() 
    {
        $markup = '<div class="button-box"><a href="/complaint/select.shtml"><span class="svg-icon svg-icon-lg">b</span> <span class="description">Submit a Tip or<br />
File a Complaint</span></a></div>';
        return [
            '#type' => 'markup',
            '#markup' => $markup,
            '#theme' => 'secgov',
        ];
    }

}
