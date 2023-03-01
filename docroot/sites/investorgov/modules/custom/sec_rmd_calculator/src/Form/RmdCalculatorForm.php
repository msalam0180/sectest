<?php

namespace Drupal\sec_rmd_calculator\Form;

use Drupal\Core\Ajax\AjaxResponse;
use Drupal\Core\Ajax\ReplaceCommand;
use Drupal\Core\Ajax\ChangedCommand;
use Drupal\Core\Form\FormBase;
use Drupal\Core\Form\FormStateInterface;
use Drupal\Core\Ajax\RemoveCommand;
use Drupal\Core\Ajax\CssCommand;
use Drupal\Core\Ajax\InvokeCommand;

/**
 * Form for Required Minimum Distribution Calculator.
 */
class RmdCalculatorForm extends FormBase {

  /**
   * {@inheritdoc}
   */
  public function getFormId() {
    return 'rmd_calculator_form';
  }

  /**
   * {@inheritdoc}
   */
  public function buildForm(array $form, FormStateInterface $form_state) {

    // Build options array for age dropdown.
    $age_options = [];
    for ($i = 73; $i <= 120; $i++) {
      // See OSSS-17667
      switch ($i) {
        // Display option text value as 120+
        case 120:
          $op_text = $this->t('120+');
          break;

        default:
          $op_text = $i;
      }
      $age_options[$i] = $op_text;
    }

    // Attach JS.
    $form['#attached']['library'][] = 'sec_calculator/sec_calculator';
    $form['#attached']['library'][] = 'sec_rmd_calculator/sec_rmd_calculator';

    // Don't cache the form.
    $form['#cache'] = ['max-age' => 0];

    $form['#attributes']['class'] = ['sec_calculator_form'];
    // Disable HTML5 browser validation, which confuses screen readers.
    $form['#attributes']['novalidate'] = 'novalidate';

    $form['#prefix'] = '<div id="rmd-calc-wrapper"><p class="form-required"><strong><span>*</span> DENOTES A REQUIRED FIELD</strong></p><div class="sec-calculator" id="rmd-calc">';
    $form['#suffix'] = '</div></div>';

    $form['calculator'] = [
      '#type' => 'container',
      '#prefix' => '<div class="calculator"><h2 class="element-invisible">Calculator</h2>',
      '#suffix' => '</div>',
      '#attributes' => ['id' => 'calculator_wrapper', 'class' => 'calculator_wrapper'],
    ];

    // Year-End Account Balance.
    $form['calculator']['account_balance'] = [
      '#type' => 'textfield',
      '#min' => 1,
      '#step' => 1,
      '#title' => t('Previous Year-End Account Balance'),
      '#size' => 10,
      '#required' => TRUE,
      '#description' => t('What was the value of your retirement account as of December 31st of last year?'),
      '#attributes' => [
        'class' => [
          'monetary-input',
          'num-input',
          'calc_textfield',
        ],
        'novalidate' => '',
      ],
      '#prefix' => '<div class="calculator__form-input">',
      '#suffix' => '</div>',

    ];

    // Age at Year-End.
    $form['calculator']['age'] = [
      '#type' => 'select',
      '#title' => t('Age at Year-End'),
      '#required' => TRUE,
      '#description' => 'How old will you be at the end of this year?',
      '#options' => $age_options,
      '#empty_option' => t('Make a selection'),
      '#attributes' => [
        'class' => ['age-select'],
        'aria-label' => ['Age at year-end'],
        'novalidate' => '',
      ],
      '#prefix' => '<div class="calculator__form-input">',
      '#suffix' => '</div>',
    ];

    $form['calculator']['actions'] = [
      '#type' => 'actions',
      '#prefix' => '<div id="rmd-calc__buttons" class="buttons">',
      '#suffix' => '</div>',
    ];

    $form['calculator']['actions']['errors'] = [
      '#prefix' => '<div id="rmd-calc__errors" class="calc-errors">',
      '#suffix' => '</div>',
    ];

    $form['calculator']['actions']['submit'] = [
      '#type' => 'submit',
      '#value' => $this->t('Calculate'),
      '#attributes' => [
        'class' => ['submit'],
        'role' => ['button'],
      ],
      '#ajax' => [
        'callback' => [$this, 'submitCallback'],
        'wrapper' => 'rmd-calc-wrapper',
        'progress' => [
          'type' => 'throbber',
          'message' => $this->t('Calculating...'),
        ],
      ],
    ];

    $form['calculator']['actions']['reset'] = [
      '#type' => 'button',
      '#button_type' => 'reset',
      '#value' => $this->t('Reset'),
    ];

    $form['results'] = [
      '#weight' => 99,
      '#prefix' => '<div aria-live="polite" tabindex="-1"><div id="results_container" class="results-container element-invisible calculator__results"><div class="results-container__inner">',
      '#suffix' => '</div></div></div>',
      '#markup' => '',
    ];

    return ['form' => $form];
  }

  /**
   * {@inheritdoc}
   */
  public function validateForm(array &$form, FormStateInterface $form_state) {
    //parent::validateForm($form, $form_state);
    $values = $form_state->getValues();
    //if ($values['account_balance'] < 1) {
    //  $form_state->setErrorByName('account_balance', $this->t('The account balance must be greater than zero.'));
    //}

    $badSymbols = [',', '$', '%'];
    if (isset($values['account_balance']) && !is_numeric(str_replace($badSymbols, "", $values['account_balance']))) {
      $form_state->setErrorByName('account_balance', $this->t('Account Balance requires numbers only.'));
    }

    if (isset($values['account_balance']) && str_replace($badSymbols, "", $values['account_balance']) > 999999999) {
      $form_state->setErrorByName('account_balance', $this->t('Account Balance cannot be above $999,999,999.'));
    }

    if (isset($values['account_balance']) && str_replace($badSymbols, "", $values['account_balance']) <= 0) {
      $form_state->setErrorByName('account_balance', $this->t('Account Balance must be above zero.'));
    }
  }

  /**
   * {@inheritdoc}
   */
  public function submitForm(array &$form, FormStateInterface $form_state) {
    // Empty function, since form is submitted through AJAX.
  }

  /**
   * Form AJAX submit callback.
   */
  public function submitCallback(array &$form, FormStateInterface $form_state) {
    if (!$errors = $form_state->getErrors()) {
      $results = $this->calculateResult($form, $form_state);

      $response = new AjaxResponse();
      $response->addCommand(new ReplaceCommand('#results_container', $results));
      $response->addCommand(new ChangedCommand('#results_container', '#results_container'));

      //clear any ajax error messages when required fields are validated
      $response->addCommand(new RemoveCommand('.messages.messages--error'));
      $response->addCommand(new InvokeCommand('div.calculator input', 'removeClass', ['error']));
      $response->addCommand(new CssCommand('div.form-item--error-message', ['display' => 'none']));

      return $response;
    }
    else {
      $form_state->setRebuild();
      return $form;
    }
  }

  /**
   * Calculate the required minimum distribution.
   */
  public function calculateResult(array &$form, FormStateInterface $form_state) {
    $age = $form_state->getValue('age');
    $badSymbols = [',', '$', '%'];
    $account_balance = str_replace($badSymbols, "", $form_state->getValue('account_balance'));
    $withdrawal_factor = $this->getWithdrawalfactor($age);
    setlocale(LC_MONETARY, 'en_US');
    $required_min_dist = ($account_balance / $withdrawal_factor);
    $rate_return = (($account_balance / ($account_balance - $required_min_dist)) - 1);
    $results = "";
    $results .= "
      <div id='results_container' class='calculator__results results-container' tabindex='-1' aria-live='polite'>
        <h2>Results</h2>
        <h3 class='calculator__results-amount'>Withdrawal Factor <span class='amount'>" . $withdrawal_factor . "</span></h3>
        <p class='calculator__results-note'>Dividing your account value by this factor determines your annual distribution amount. To account for life expectancy, we refer to IRS Pub. 590 Table III: Uniform Lifetime.</p>
        <h3 class='calculator__results-amount'>Required Minimum Distribution <span class='amount'>$" . number_format($required_min_dist, 2) . "</span></h3>
        <p class='calculator__results-note'>Note that the timing of the withdrawal, changes in marital status or beneficiary age, and the death of an account owner also factor into your required minimum distribution. Because of these factors, your results may be higher or lower than those shown.</p>
      </div>";
    return $results;
  }

  /**
   * Get Withdrawal Factor.
   *
   * This data comes from IRS Pub. 590 Table III: Uniform Lifetime.
   */
  private function getWithdrawalFactor($age) {
    // Updated factor values, see OSSS-17667
    $factor = [
      '72' => 27.4,
      '73' => 26.5,
      '74' => 25.5,
      '75' => 24.6,
      '76' => 23.7,
      '77' => 22.9,
      '78' => 22,
      '79' => 21.1,
      '80' => 20.2,
      '81' => 19.4,
      '82' => 18.5,
      '83' => 17.7,
      '84' => 16.8,
      '85' => 16,
      '86' => 15.2,
      '87' => 14.4,
      '88' => 13.7,
      '89' => 12.9,
      '90' => 12.2,
      '91' => 11.5,
      '92' => 10.8,
      '93' => 10.1,
      '94' => 9.5,
      '95' => 8.9,
      '96' => 8.4,
      '97' => 7.8,
      '98' => 7.3,
      '99' => 6.8,
      '100' => 6.4,
      '101' => 6,
      '102' => 5.6,
      '103' => 5.2,
      '104' => 4.9,
      '105' => 4.6,
      '106' => 4.3,
      '107' => 4.1,
      '108' => 3.9,
      '109' => 3.7,
      '110' => 3.5,
      '111' => 3.4,
      '112' => 3.3,
      '113' => 3.1,
      '114' => 3,
      '115' => 2.9,
      '116' => 2.8,
      '117' => 2.7,
      '118' => 2.5,
      '119' => 2.3,
      '120' => 2,
    ];
    return $factor[$age] ?? 0;
  }

}
