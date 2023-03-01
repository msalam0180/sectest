<?php

namespace Drupal\media_entity_link\Plugin\media\Source;

use Drupal\Core\Entity\Display\EntityViewDisplayInterface;
use Drupal\media\MediaTypeInterface;
use Drupal\media\MediaSourceBase;

/**
 * Media source wrapping around link media entity fields.
 *
 * @see \Drupal\file\FileInterface
 *
 * @MediaSource(
 *   id = "link",
 *   label = @Translation("Link"),
 *   description = @Translation("Use link for reusable media."),
 *   allowed_field_types = {"link"},
 *   default_thumbnail_filename = "no-thumbnail.png",
 *   forms = {
 *     "media_library_add" = "\Drupal\media_entity_link\Form\LinkMediaLibraryAddForm",
 *   }
 * )
 */
class MediaEntityLink extends MediaSourceBase {

  /**
   * {@inheritdoc}
   */
  public function getMetadataAttributes() {
    return [];
  }

  /**
   * {@inheritdoc}
   */
  public function createSourceField(MediaTypeInterface $type) {
    return parent::createSourceField($type)->set('label', 'Link');
  }

  /**
   * {@inheritdoc}
   */
  public function prepareViewDisplay(MediaTypeInterface $type, EntityViewDisplayInterface $display) {
    $display->setComponent($this->getSourceFieldDefinition($type)->getName(), [
      'type' => 'link',
      'label' => 'hidden',
    ]);
  }

}
