<?php

namespace Drupal\media_entity_link\Form;

use Drupal\Component\Utility\UrlHelper;
use Drupal\Core\Entity\Element\EntityAutocomplete;
use Drupal\Core\Form\FormBuilderInterface;
use Drupal\Core\Form\FormStateInterface;
use Drupal\Core\Url;
use Drupal\link\LinkItemInterface;
use Drupal\media\MediaTypeInterface;
use Drupal\media_library\Form\AddFormBase;

/**
 * Creates a form to add media entity link in Media Library.
 */
class LinkMediaLibraryAddForm extends AddFormBase {

  /**
   * {@inheritdoc}
   */
  public function getFormId() {
    return 'media_entity_link_media_library_add';
  }

  /**
   * {@inheritdoc}
   */
  protected function buildInputElement(array $form, FormStateInterface $form_state) {
    $media_type = $this->getMediaType($form_state);

    $form['container'] = [
      '#type' => 'container',
      '#title' => $this->t('Add @type', [
        '@type' => $media_type->label(),
      ]),
    ];
    $form['container']['url'] = [
      '#type' => 'url',
      '#title' => $this->t('URL'),
      '#required' => TRUE,
      '#element_validate' => [[static::class, 'validateUriElement']],
      '#link_type' => $this->getSourceFieldDefinition($media_type)->getSetting('link_type'),
    ];

    // If the field is configured to support internal links, it cannot use the
    // 'url' form element and we have to do the validation ourselves.
    if ($this->supportsInternalLinks($media_type)) {
      $form['container']['url']['#type'] = 'entity_autocomplete';
      // @todo The user should be able to select an entity type. Will be fixed
      //    in https://www.drupal.org/node/2423093.
      $form['container']['url']['#target_type'] = 'node';
      // Disable autocompletion when the first character is '/', '#' or '?'.
      $form['container']['url']['#attributes']['data-autocomplete-first-character-blacklist'] = '/#?';

      // The link widget is doing its own processing in
      // static::getUriAsDisplayableString().
      $form['container']['url']['#process_default_value'] = FALSE;
    }

    // If the field is configured to allow only internal links, add a useful
    // element prefix and description.
    if (!$this->supportsExternalLinks($media_type)) {
      $form['container']['url']['#field_prefix'] = rtrim(Url::fromRoute('<front>', [], ['absolute' => TRUE])->toString(), '/');
      $form['container']['url']['#description'] = $this->t('This must be an internal path such as %add-node. You can also start typing the title of a piece of content to select it. Enter %front to link to the front page. Enter %nolink to display link text only. Enter %button to display keyboard-accessible link text only.', ['%add-node' => '/node/add', '%front' => '<front>', '%nolink' => '<nolink>', '%button' => 'route:<button>']);
    }
    // If the field is configured to allow both internal and external links,
    // show a useful description.
    elseif ($this->supportsExternalLinks($media_type) && $this->supportsInternalLinks($media_type)) {
      $form['container']['url']['#description'] = $this->t('Start typing the title of a piece of content to select it. You can also enter an internal path such as %add-node or an external URL such as %url. Enter %front to link to the front page. Enter %nolink to display link text only. Enter %button to display keyboard-accessible link text only.', ['%front' => '<front>', '%add-node' => '/node/add', '%url' => 'http://example.com', '%nolink' => '<nolink>', '%button' => 'route:<button>']);
    }
    // If the field is configured to allow only external links, show a useful
    // description.
    elseif ($this->supportsExternalLinks($media_type) && !$this->supportsInternalLinks($media_type)) {
      $form['container']['url']['#description'] = $this->t('This must be an external URL such as %url.', ['%url' => 'http://example.com']);
    }

    $form['container']['submit'] = [
      '#type' => 'submit',
      '#value' => $this->t('Add'),
      '#button_type' => 'primary',
      '#submit' => ['::addButtonSubmit'],
      '#ajax' => [
        'callback' => '::updateFormCallback',
        'wrapper' => 'media-library-wrapper',
        // Add a fixed URL to post the form since AJAX forms are automatically
        // posted to <current> instead of $form['#action'].
        // @todo Remove when https://www.drupal.org/project/drupal/issues/2504115
        // is fixed.
        'url' => Url::fromRoute('media_library.ui'),
        'options' => [
          'query' => $this->getMediaLibraryState($form_state)->all() + [
            FormBuilderInterface::AJAX_FORM_REQUEST => TRUE,
          ],
        ],
      ],
    ];

    return $form;
  }

  /**
   * Indicates enabled support for link to routes.
   *
   * @return bool
   *   Returns TRUE if the LinkItem field is configured to support links to
   *   routes, otherwise FALSE.
   */
  protected function supportsInternalLinks($media_type) {
    $link_type = $this->getSourceFieldDefinition($media_type)->getSetting('link_type');
    return (bool) ($link_type & LinkItemInterface::LINK_INTERNAL);
  }

  /**
   * Indicates enabled support for link to external URLs.
   *
   * @return bool
   *   Returns TRUE if the LinkItem field is configured to support links to
   *   external URLs, otherwise FALSE.
   */
  protected function supportsExternalLinks($media_type) {
    $link_type = $this->getSourceFieldDefinition($media_type)->getSetting('link_type');
    return (bool) ($link_type & LinkItemInterface::LINK_EXTERNAL);
  }

  /**
   * Validates the URL.
   *
   * @param array $form
   *   The complete form.
   * @param \Drupal\Core\Form\FormStateInterface $form_state
   *   The current form state.
   */
  public function validateUriElement(array &$form, FormStateInterface $form_state) {
    $uri = static::getUserEnteredStringAsUri($form_state->getValue('url'));
    // If getUserEnteredStringAsUri() mapped the entered value to an 'internal:'
    // URI , ensure the raw value begins with '/', '?' or '#'.
    // @todo '<front>' is valid input for BC reasons, may be removed by
    //   https://www.drupal.org/node/2421941
    if (parse_url($uri, PHP_URL_SCHEME) === 'internal' && !in_array($form['#value'][0], ['/', '?', '#'], TRUE) && substr($form['#value'], 0, 7) !== '<front>') {
      $form_state->setError($form, $this->t('Manually entered paths should start with one of the following characters: / ? #'));
      return;
    }
    $uri_is_valid = TRUE;
    $link_type = $form['#link_type'];
    if ($link_type !== LinkItemInterface::LINK_GENERIC) {
      if (!($link_type & LinkItemInterface::LINK_EXTERNAL) && UrlHelper::isExternal($form_state->getValue('url'))) {
        $uri_is_valid = FALSE;
      }
      if (!($link_type & LinkItemInterface::LINK_INTERNAL) && !UrlHelper::isExternal($form_state->getValue('url'))) {
        $uri_is_valid = FALSE;
      }
    }
    if (!$uri_is_valid) {
      $form_state->setError($form, $this->t('The path @uri is invalid.', ['@uri' => $form_state->getValue('url')]));
      return;
    }
  }

  /**
   * Gets the user-entered string as a URI.
   *
   * The following two forms of input are mapped to URIs:
   * - entity autocomplete ("label (entity id)") strings: to 'entity:' URIs;
   * - strings without a detectable scheme: to 'internal:' URIs.
   *
   * This method is the inverse of ::getUriAsDisplayableString().
   *
   * @param string $string
   *   The user-entered string.
   *
   * @return string
   *   The URI, if a non-empty $uri was passed.
   *
   * @see static::getUriAsDisplayableString()
   */
  protected static function getUserEnteredStringAsUri($string) {
    // By default, assume the entered string is a URI.
    $uri = trim($string);

    // Detect entity autocomplete string, map to 'entity:' URI.
    $entity_id = EntityAutocomplete::extractEntityIdFromAutocompleteInput($string);
    if ($entity_id !== NULL) {
      // @todo Support entity types other than 'node'. Will be fixed in
      //    https://www.drupal.org/node/2423093.
      $uri = 'entity:node/' . $entity_id;
    }
    // Support linking to nothing.
    elseif (in_array($string, ['<nolink>', '<none>'], TRUE)) {
      $uri = 'route:' . $string;
    }
    // Detect a schemeless string, map to 'internal:' URI.
    elseif (!empty($string) && parse_url($string, PHP_URL_SCHEME) === NULL) {
      // @todo '<front>' is valid input for BC reasons, may be removed by
      //   https://www.drupal.org/node/2421941
      // - '<front>' -> '/'
      // - '<front>#foo' -> '/#foo'
      if (strpos($string, '<front>') === 0) {
        $string = '/' . substr($string, strlen('<front>'));
      }
      $uri = 'internal:' . $string;
    }
    return $uri;
  }

  /**
   * Submit handler for the add button.
   *
   * @param array $form
   *   The form render array.
   * @param \Drupal\Core\Form\FormStateInterface $form_state
   *   The form state.
   */
  public function addButtonSubmit(array $form, FormStateInterface $form_state) {
    $this->processInputValues([$form_state->getValue('url')], $form, $form_state);
  }

  /**
   * Returns the definition of the source field for a media type.
   *
   * @param \Drupal\media\MediaTypeInterface $media_type
   *   The media type to get the source definition for.
   *
   * @return \Drupal\Core\Field\FieldDefinitionInterface|null
   *   The field definition.
   */
  protected function getSourceFieldDefinition(MediaTypeInterface $media_type) {
    return $media_type->getSource()->getSourceFieldDefinition($media_type);
  }

}
