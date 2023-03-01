<?php

namespace Drupal\sec_link_target\Plugin\Field\FieldWidget;

use Drupal\Core\Field\FieldItemListInterface;
use Drupal\Core\Form\FormStateInterface;
use Drupal\link\Plugin\Field\FieldWidget\LinkWidget;

/**
 * Implementation of the link target module.
 *
 * @FieldWidget(
 *   label = @Translation("Link with target attribute"),
 *   id = "link_attributes",
 *   field_types = {
 *   "link"
 *   }
 * )
 */
class LinkTargetWidget extends LinkWidget {

  public function formElement(FieldItemListInterface $items, $delta, array $element, array &$form, FormStateInterface $form_state) {
    $element = parent::formElement($items, $delta, $element, $form, $form_state);

    $item = $items[$delta];

    $options = $item->get('options')->getValue();
    $attributes = isset($options['attributes']) ? $options['attributes'] : [];

    $element['options']['attributes']['target'] = [
      '#type' => 'select',
      '#title' => 'Target',
      '#description' => $this->t('Enter value for the @attribute attribute', ['@attribute' => 'target']),
      '#default_value' => isset($attributes['target']) ? $attributes['target'] : '',
      '#options' => ['_blank' => 'Blank (New Window)', '_self' => 'Self (Current Window)'],
      '#required' => true,
    ];

    return $element;
  }
}
