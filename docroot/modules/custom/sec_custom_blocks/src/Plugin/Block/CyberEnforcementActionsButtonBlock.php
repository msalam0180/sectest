<?php

/**
 * @file
 * Contains \src\Plugin\Block\SecMissionBlock.
 */

namespace Drupal\sec_custom_blocks\Plugin\Block;

use Drupal\Core\Block\BlockBase;

/**
 * Provides a Cyber Enforcement Actions Button Block.
 *
 * @Block(
 *   id = "cyber_enforcement_actions_button_block",
 *   admin_label = @Translation("Cyber Enforcement Actions Button"),
 * )
 */

class CyberEnforcementActionsButtonBlock extends BlockBase {

    /**
     * {@inheritdoc}
     */
    public function build() {
        $markup = '<div class="button-box"><a href="/spotlight/cybersecurity-enforcement-actions"><span class="svg-icon svg-icon-lg">a</span> <span class="description">Cyber<br />
Enforcement Actions</span></a></div>';
        return array(
            '#type' => 'markup',
            '#markup' => $markup,
            '#theme' => 'secgov',
        );
    }

}
