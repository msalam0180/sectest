<?php

/**
 * @file
 * HTML-related hook implementations.
 */

/**
 * Implements hook_preprocess().
 */
function uswdssec_preprocess(array &$variables) {
  if (!empty($variables['directory'])) {
    $variables['gesso_image_path'] = '/' . $variables['directory'] . '/dist/images';
  }
}

/**
 * Implements hook_preprocess_HOOK().
 */
function uswdssec_preprocess_html(array &$variables) {
  $variables['include_back_to_top']
    = theme_get_setting('include_back_to_top', 'uswdssec') ?? TRUE;
  /** @var \Drupal\Core\Render\Renderer $renderer */
  $renderer = \Drupal::service('renderer');
  $themeConfig = \Drupal::config('uswdssec.settings');
  $renderer->addCacheableDependency($variables, $themeConfig);

  // add status code as a body class
  $statusCode = Drupal::request()->query->get('_exception_statuscode');
    if (isset($statusCode) and (($statusCode == 404) or ($statusCode == 403))) {
      $variables['attributes']['class'][] = 'page-statuscode-' . $statusCode;
    }
}

/**
 * Implements hook_page_attachments_alter().
 */
function uswdssec_page_attachments_alter(array &$attachments) {
  $include_back_to_top = theme_get_setting('include_back_to_top') ?? TRUE;
  if ($include_back_to_top) {
    $attachments['#attached']['drupalSettings']['gesso']['backToTopThreshold']
      = theme_get_setting('threshold', 'uswdssec');
    $attachments['#attached']['drupalSettings']['gesso']['backToTopSmoothScroll']
      = theme_get_setting('smooth_scroll', 'uswdssec');
    /** @var \Drupal\Core\Render\Renderer $renderer */
    $renderer = \Drupal::service('renderer');
    $themeConfig = \Drupal::config('uswdssec.settings');
    $renderer->addCacheableDependency($attachments, $themeConfig);

  }
}
