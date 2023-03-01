<?php

/**
 * @file
 * Contains \src\Plugin\Block\RegulateSecuritiesButtonBlock.
 */

namespace Drupal\sec_custom_blocks\Plugin\Block;

use Drupal\Core\Block\BlockBase;

/**
 * Provides an EDGAR Search block.
 *
 * @Block(
 *   id = "regulate_securities_button_block",
 *   admin_label = @Translation("Regulate Securities Buttons"),
 * )
 */

class RegulateSecuritiesButtonBlock extends BlockBase
{

    /**
     * {@inheritdoc}
     */
    public function build() 
    {
        $markup = '<div class="block homepage-public-comments">
            <div data-quickedit-field-id="block_content/746/body/en/full" class="body"><div class="callout">
<div class="field-icon"><img alt="People" data-entity-type="file" src="/sites/default/files/inline-images/people.png"></div>

<div class="field-title">Public Comments</div>
</div>

<div class="callout">
<div class="field-icon"><img alt="Notepad" data-entity-type="file" src="/sites/default/files/inline-images/notepad.png"></div>

<div class="field-title">VIEW FINAL RULES</div>
</div><div class="callout-hover">
<p>Need Content</p>
</div>
</div>

  </div>';
        return [
            '#type' => 'markup',
            '#markup' => $markup,
        ];
    }

}
