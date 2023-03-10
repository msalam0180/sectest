<?php

namespace Drupal\Tests\workbench_moderation\Unit;

use Prophecy\PhpUnit\ProphecyTrait;
use Drupal\block_content\Entity\BlockContent;
use Drupal\Core\Access\AccessResultAllowed;
use Drupal\Core\Access\AccessResultForbidden;
use Drupal\Core\Routing\RouteMatch;
use Drupal\node\Entity\Node;
use Drupal\Tests\UnitTestCase;
use Drupal\workbench_moderation\Access\LatestRevisionCheck;
use Drupal\workbench_moderation\ModerationInformation;
use Symfony\Component\Routing\Route;

/**
 * @coversDefaultClass \Drupal\workbench_moderation\Access\LatestRevisionCheck
 * @group workbench_moderation
 */
class LatestRevisionCheckTest extends UnitTestCase {

  use ProphecyTrait;
  /**
   * Test the access check of the LatestRevisionCheck service.
   *
   * @param string $entity_class
   *   The class of the entity to mock.
   * @param string $entity_type
   *   The machine name of the entity to mock.
   * @param bool $has_forward
   *   Whether this entity should have a forward revision in the system.
   * @param string $result_class
   *   The AccessResult class that should result. One of AccessResultAllowed,
   *   AccessResultForbidden, AccessResultNeutral.
   *
   * @dataProvider accessSituationProvider
   */
  public function testLatestAccessPermissions($entity_class, $entity_type, $has_forward, $result_class) {

    /** @var \Drupal\Core\Entity\EntityInterface $entity */
    $entity = $this->prophesize($entity_class);
    $entity->getCacheContexts()->willReturn([]);
    $entity->getCacheTags()->willReturn([]);
    $entity->getCacheMaxAge()->willReturn(0);

    /** @var \Drupal\workbench_moderation\ModerationInformationInterface $mod_info */
    $mod_info = $this->prophesize(ModerationInformation::class);
    $mod_info->hasForwardRevision($entity->reveal())->willReturn($has_forward);

    $route = $this->prophesize(Route::class);

    $route->getOption('_workbench_moderation_entity_type')->willReturn($entity_type);

    $route_match = $this->prophesize(RouteMatch::class);
    $route_match->getParameter($entity_type)->willReturn($entity->reveal());

    $lrc = new LatestRevisionCheck($mod_info->reveal());

    /** @var \Drupal\Core\Access\AccessResult $result */
    $result = $lrc->access($route->reveal(), $route_match->reveal());

    $this->assertInstanceOf($result_class, $result);

  }

  /**
   * Data provider for testLastAccessPermissions().
   *
   * @return array
   *   Array with node access and block content access.
   */
  public function accessSituationProvider() {
    return [
      [Node::class, 'node', TRUE, AccessResultAllowed::class],
      [Node::class, 'node', FALSE, AccessResultForbidden::class],
      [BlockContent::class, 'block_content', TRUE, AccessResultAllowed::class],
      [BlockContent::class,
        'block_content',
        FALSE,
        AccessResultForbidden::class,
      ],
    ];
  }

}
