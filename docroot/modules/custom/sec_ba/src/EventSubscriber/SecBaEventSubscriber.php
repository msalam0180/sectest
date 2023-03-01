<?php

/**
 * @file
 * Contains \Drupal\sec_ba\EventSubscriber\SecBaEventSubscriber
 */

namespace Drupal\sec_ba\EventSubscriber;

use Drupal\Core\Routing\RouteMatchInterface;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpKernel\Event\RequestEvent;
use Symfony\Component\HttpKernel\KernelEvents;


class SecBaEventSubscriber implements EventSubscriberInterface
{


    /**
   * The current route match.
   *
   * @var \Drupal\Core\Routing\RouteMatchInterface
   */
    protected $routeMatch;

    /**
   * Constructs a new SecBaEventSubscriber object.
   *
   * @param \Drupal\Core\Routing\RouteMatchInterface $route_match
   *   The current route match.
   */
    public function __construct(RouteMatchInterface $route_match)
    {
        $this->routeMatch = $route_match;
    }
    /**
   * {@inheritdoc}
   */
    public static function getSubscribedEvents()
    {
        return([
        KernelEvents::REQUEST => [
        ['iddAdminOptions']
        ]
        ]);
    }

    /**
   * Sets options for admin/content/idd search page
   *
   * @param  RequestEvent $event
   */
    public function iddAdminOptions(RequestEvent $event)
    {
        $request = $event->getRequest();
        if ($request->getpathInfo() === "/admin/content/idd") {
            $this->routeMatch->getRouteObject()->setOption('_no_big_pipe', true);
        }
    }

}
