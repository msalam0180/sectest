<?php

/**
 * @file
 * Contains \src\Plugin\Block\SecMissionBlock.
 */

namespace Drupal\sec_custom_blocks\Plugin\Block;

use Drupal\Core\Block\BlockBase;

/**
 * Provides a SEC Mission Block.
 *
 * @Block(
 *   id = "sec_mission_block",
 *   admin_label = @Translation("SEC Mission"),
 * )
 */

class SecMissionBlock extends BlockBase
{

    /**
     * {@inheritdoc}
     */
    public function build() 
    {
        return [
            '#type' => 'markup',
            '#markup' => '',
            '#theme' => 'block__sec_mission_block',
        ];
    }

}
