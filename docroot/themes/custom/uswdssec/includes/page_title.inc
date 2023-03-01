<?php

/**
 * @file
 * Page Title hook implementations.
 */

/**
 * Implements hook_preprocess_page_title().
 */
function uswdssec_preprocess_page_title(&$variables) {
  // If Node Page
  $node = \Drupal::request()->attributes->get('node');
  
  if (is_string($node)) {
    $node = Node::load($node);
  }

  if($node && !is_string($node)) {
    if ($node->hasField("field_display_title")){
      $displayTitle = $node->get('field_display_title')->value;
      if (!empty($displayTitle)){
        $variables['displayTitle'] = $displayTitle;
        $variables['title'] = $displayTitle;
      }
    }
  }
}
