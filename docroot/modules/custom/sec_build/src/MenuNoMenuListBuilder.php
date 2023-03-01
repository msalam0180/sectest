<?php

namespace Drupal\sec_build;

use Drupal\Core\Entity\EntityInterface;
use Drupal\menu_ui\MenuListBuilder;

/**
 * Alters the MenuListBuilder to remove 'No Menu' menu from display
 *
 * @see \Drupal\system\Entity\Menu
 * @see menu_entity_info()
 */
class MenuNoMenuListBuilder extends MenuListBuilder {

  /**
   * {@inheritdoc}
   */
  public function buildHeader() {
    $header['title'] = t('Title');
    $header['description'] = [
      'data' => t('Description'),
      'class' => [RESPONSIVE_PRIORITY_MEDIUM],
    ];
    return $header + parent::buildHeader();
  }

  /**
   * {@inheritdoc}
   */
  public function buildRow(EntityInterface $entity) {
    if ($entity->id() != 'no-menu') {
      $row['title'] = [
        'data' => $entity->label(),
        'class' => ['menu-label'],
      ];
      $row['description']['data'] = ['#markup' => $entity->getDescription()];
      return $row + parent::buildRow($entity);
    }
    return FALSE;
  }

  /**
   * {@inheritdoc}
   */
  public function getDefaultOperations(EntityInterface $entity) {
    $operations = parent::getDefaultOperations($entity);

    if (isset($operations['edit'])) {
      $operations['edit']['title'] = t('Edit menu');
      $operations['add'] = [
        'title' => t('Add link'),
        'weight' => 20,
        'url' => $entity->toUrl('add-link-form'),
      ];
    }
    if (isset($operations['delete'])) {
      $operations['delete']['title'] = t('Delete menu');
    }
    return $operations;
  }

  /**
   * {@inheritdoc}
   */
  public function render() {
    $build = parent::render();
    $build['#attached']['library'][] = "menu_ui/drupal.menu_ui.adminforms";
    return $build;
  }
}
