<?php

/**
 * @file
 * Navigation-related hook implementations.
 */

/**
 * Implements hook_preprocess_breadcrumb().
 */
function uswdssec_preprocess_breadcrumb(array &$variables) {
  if ($variables['breadcrumb']) {
    /** @var \Drupal\Core\Render\Renderer $renderer */
    $renderer = \Drupal::service('renderer');
    $variables['include_current_page']
      = theme_get_setting('include_current_page_in_breadcrumb', 'uswdssec') ?? TRUE;
    $themeConfig = \Drupal::config('uswdssec.settings');
    $renderer->addCacheableDependency($variables, $themeConfig);

    // Alter "text" to be "Display Title" in the breadcrumb array for ancestors
    foreach ($variables['breadcrumb'] as $key => $value) {
      if ($variables['breadcrumb'][$key]['url']){
        // get node via url
        $path = \Drupal::service('path_alias.manager')->getPathByAlias($variables['breadcrumb'][$key]['url']);
        if(preg_match('/node\/(\d+)/', $path, $matches)) {
          $node[$key] = \Drupal\node\Entity\Node::load($matches[1]);
        }
  
        // If there is a "display title" use that as the "Text"
        if($node[$key] && !is_string($node[$key]) && $node[$key]->hasField("field_display_title")) {
          $displayTitle = $node[$key]->get('field_display_title')->value;
          $variables['breadcrumb'][$key]['text'] = $displayTitle;
        }
      }
    }

    // Current page at the end of the URL 
    if ($variables['include_current_page']) {
      $request = \Drupal::request();
      $route_match = \Drupal::routeMatch();
      $variables['#cache']['contexts'][] = 'route';
      $page_title = \Drupal::service('title_resolver')->getTitle($request, $route_match->getRouteObject());

      $node = \Drupal::request()->attributes->get('node');
  
      if (is_string($node)) {
        $node = Node::load($node);
      }

      // If node and has field field_display_title
      if($node && !is_string($node) && $node->hasField("field_display_title")) {
        $displayTitle = $node->get('field_display_title')->value;
        if (!empty($displayTitle)){
          $page_title = $displayTitle;
        }
      }
      
      if (!empty($page_title)) {
        $variables['page_title'] = $page_title;
        $variables['breadcrumb'][] = [
          'text' => $page_title,
        ];
      }
    }
  }
}
