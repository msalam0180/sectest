<?php

namespace Drupal\sec_admin\Routing;

use Drupal\Core\Routing\RouteSubscriberBase;
use Symfony\Component\Routing\RouteCollection;

class RouteSubscriber extends RouteSubscriberBase {

  /**
   * {@inheritdoc}
   */
  protected function alterRoutes(RouteCollection $collection) {
    if ($route = $collection->get('simple_sitemap.sitemap_default')) {
      $route->setPath('/sec-sitemap.xml');
    }
  }

}
