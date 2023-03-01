<?php

/**
 * @file
 * Contains \src\Plugin\Block\HomeEmailUpdatesBlock.
 */

namespace Drupal\sec_custom_blocks\Plugin\Block;

use Drupal\Core\Block\BlockBase;

/**
 * Provides an Email update block.
 *
 * @Block(
 *   id = "home_email_updates_block",
 *   admin_label = @Translation("Home Email Update"),
 * )
 */

class HomeEmailUpdatesBlock extends BlockBase
{

    /**
     * {@inheritdoc}
     */
    public function build() 
    {
        $markup = '';
        return [
            '#type' => 'markup',
            '#markup' => $markup,
            '#theme' => 'sec_custom_blocks',
        ];
    }

}