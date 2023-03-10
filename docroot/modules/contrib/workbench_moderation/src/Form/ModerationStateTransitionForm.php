<?php

namespace Drupal\workbench_moderation\Form;

use Drupal\Core\Entity\EntityForm;
use Drupal\Core\Entity\EntityTypeManagerInterface;
use Drupal\Core\Form\FormStateInterface;
use Symfony\Component\DependencyInjection\ContainerInterface;

/**
 * Class ModerationStateTransitionForm.
 *
 * @package Drupal\workbench_moderation\Form
 */
class ModerationStateTransitionForm extends EntityForm {

  /**
   * An entity type manager.
   *
   * @var \Drupal\Core\Entity\EntityTypeManagerInterface
   */
  protected $entityTypeManager;

  /**
   * Constructs a new ModerationStateTransitionForm.
   *
   * @param \Drupal\Core\Entity\EntityTypeManagerInterface $entity_type_manager
   *   Entity type manager.
   */
  public function __construct(EntityTypeManagerInterface $entity_type_manager) {
    $this->entityTypeManager = $entity_type_manager;
  }

  /**
   * {@inheritdoc}
   */
  public static function create(ContainerInterface $container) {
    return new static($container->get('entity_type.manager'));
  }

  /**
   * {@inheritdoc}
   */
  public function form(array $form, FormStateInterface $form_state) {
    $form = parent::form($form, $form_state);

    /* @var \Drupal\workbench_moderation\ModerationStateTransitionInterface $moderation_state_transition */
    $moderation_state_transition = $this->entity;
    $form['label'] = [
      '#type' => 'textfield',
      '#title' => $this->t('Label'),
      '#maxlength' => 255,
      '#default_value' => $moderation_state_transition->label(),
      '#description' => $this->t("Label for the Moderation state transition."),
      '#required' => TRUE,
    ];

    $form['id'] = [
      '#type' => 'machine_name',
      '#default_value' => $moderation_state_transition->id(),
      '#machine_name' => [
        'exists' => '\Drupal\workbench_moderation\Entity\ModerationStateTransition::load',
      ],
      '#disabled' => !$moderation_state_transition->isNew(),
    ];

    $options = [];
    foreach ($this->entityTypeManager->getStorage('moderation_state')->loadMultiple() as $moderation_state) {
      $options[$moderation_state->id()] = $moderation_state->label();
    }

    $form['container'] = [
      '#type' => 'container',
      '#attributes' => [
        'class' => ['container-inline'],
      ],
    ];

    $form['container']['stateFrom'] = [
      '#type' => 'select',
      '#title' => $this->t('Transition from'),
      '#options' => $options,
      '#required' => TRUE,
      '#empty_option' => $this->t('-- Select --'),
      '#default_value' => $moderation_state_transition->getFromState(),
    ];

    $form['container']['stateTo'] = [
      '#type' => 'select',
      '#options' => $options,
      '#required' => TRUE,
      '#title' => $this->t('Transition to'),
      '#empty_option' => $this->t('-- Select --'),
      '#default_value' => $moderation_state_transition->getToState(),
    ];

    // Make sure there's always at least a wide enough delta on weight to cover
    // the current value or the total number of transitions. That way we
    // never end up forcing a transition to change its weight needlessly.
    $num_transitions = $this->entityTypeManager->getStorage('moderation_state_transition')->getQuery()->count()->execute();
    $delta = max(abs($moderation_state_transition->getWeight() ?? 0), $num_transitions);

    $form['weight'] = [
      '#type' => 'weight',
      '#delta' => $delta,
      '#options' => $options,
      '#title' => $this->t('Weight'),
      '#default_value' => $moderation_state_transition->getWeight(),
      '#description' => $this->t('Orders the transitions in moderation forms and the administrative listing. Heavier items will sink and the lighter items will be positioned nearer the top.'),
    ];

    return $form;
  }

  /**
   * {@inheritdoc}
   */
  public function save(array $form, FormStateInterface $form_state) {
    $moderation_state_transition = $this->entity;
    $status = $moderation_state_transition->save();

    switch ($status) {
      case SAVED_NEW:
        $this->messenger()->addMessage($this->t('Created the %label Moderation state transition.', [
          '%label' => $moderation_state_transition->label(),
        ]));
        break;

      default:
        $this->messenger()->addMessage($this->t('Saved the %label Moderation state transition.', [
          '%label' => $moderation_state_transition->label(),
        ]));
    }
    $form_state->setRedirectUrl($moderation_state_transition->toUrl('collection'));
  }

}
