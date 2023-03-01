<?php

/**
 * @file
 * Contains \src\Plugin\Block\SecMissionBlock.
 */

namespace Drupal\sec_custom_blocks\Plugin\Block;

use Drupal\Core\Block\BlockBase;

/**
 * Provides a Public Comments Final Rules Combo Button.
 *
 * @Block(
 *   id = "public_comments_final_rules_combo_button_block",
 *   admin_label = @Translation("Public Comments Final Rules Combo Button"),
 * )
 */

class PublicCommentsFinalRulesComboButtonBlock extends BlockBase
{

    /**
     * {@inheritdoc}
     */
    public function build() 
    {
        $markup = '<div class="callout"><a href="/rules/submitcomments.htm">
<div class="field-icon"><img alt="People" data-entity-type="file" src="/sites/default/files/inline-images/people.png" /></div>

<div class="field-title">Public Comments</div>
</a></div>

<div class="callout"><a href="rules/final.shtml">
<div class="field-icon"><img alt="Notepad" data-entity-type="file" src="/sites/default/files/inline-images/notepad.png" /></div>

<div class="field-title">VIEW FINAL RULES</div>
</a></div>';
        return [
            '#type' => 'markup',
            '#markup' => $markup,
            '#theme' => 'secgov',
        ];
    }

}
