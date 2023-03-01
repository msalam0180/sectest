<?php

namespace Drupal\sec_savings_calculator\Form;

use Drupal\Core\Ajax\AjaxResponse;
use Drupal\Core\Ajax\ReplaceCommand;
use Drupal\Core\Ajax\ChangedCommand;
use Drupal\Core\Form\FormBase;
use Drupal\Core\Form\FormStateInterface;
use Drupal\Core\Ajax\RemoveCommand;
use Drupal\Core\Ajax\CssCommand;
use Drupal\Core\Ajax\InvokeCommand;

/**
 * Form for Savings Goal Calculator.
 */
class SavingsCalculatorForm extends FormBase {

  /**
   * {@inheritdoc}
   */
  public function getFormId() {
    return 'savings_calculator_form';
  }

  /**
   * {@inheritdoc}
   */
  public function buildForm(array $form, FormStateInterface $form_state) {

    // Attach JS.
    $form['#attached']['library'][] = 'sec_calculator/sec_calculator';
    $form['#attached']['library'][] = 'sec_savings_calculator/sec_savings_calculator';

    // Don't cache the form.
    $form['#cache'] = ['max-age' => 0];

    $form['#attributes']['class'] = ['sec_calculator_form'];
    // Disable HTML5 browser validation, which confuses screen readers.
    $form['#attributes']['novalidate'] = 'novalidate';

    $form['#prefix'] = '<div id="savings-calc-wrapper"><p class="form-required"><strong><span>*</span> DENOTES A REQUIRED FIELD</strong></p><div class="sec-calculator" id="savings-goal-calc">';
    $form['#suffix'] = '</div></div>';

    $form['calculator'] = [
      '#type' => 'container',
      '#prefix' => '<div class="calculator"><h2 class="element-invisible">Calculator</h2>',
      '#suffix' => '</div>',
      '#attributes' => ['id' => 'calculator_wrapper', 'class' => 'calculator_wrapper'],
    ];

    $form['calculator']['end_amount_container'] = [
      '#prefix' => '<div role="presentation" class="calculator_step">',
      '#suffix' => '</div>',
      '#markup' => '<h3>' . $this->t("Step 1: Savings Goal") . '</h3>',
    ];

    $form['calculator']['end_amount_container']['end_amount'] = [
      '#type' => 'textfield',
      '#size' => 10,
      '#title' => $this->t('Savings Goal'),
      '#required' => TRUE,
      '#description' => $this->t("Desired final savings."),
      '#attributes' => [
        'class' => ['monetary-input', 'num-input'],
        'aria-labelledby' => ['end_amount_label'],
        'novalidate' => '',
      ],
      '#prefix' => '<div class="calculator__form-input">',
      '#suffix' => '</div>',
    ];

    $form['calculator']['principal_container'] = [
      '#prefix' => '<div class="calculator_step">',
      '#suffix' => '</div>',
      '#markup' => '<h3>' . $this->t("Step 2: Initial Investment") . '</h3>',
    ];

    $form['calculator']['principal_container']['principal'] = [
      '#type' => 'textfield',
      '#size' => 10,
      '#title' => $this->t('Initial Investment'),
      '#required' => TRUE,
      '#description' => $this->t("Amount of money you have readily available to invest."),
      '#attributes' => [
        'class' => ['monetary-input', 'num-input'],
        'aria-labelledby' => ['principal_label'],
        'novalidate' => '',
      ],
      '#prefix' => '<div class="calculator__form-input">',
      '#suffix' => '</div>',
    ];

    $form['calculator']['num_years_container'] = [
      '#prefix' => '<div class="calculator_step">',
      '#suffix' => '</div>',
      '#markup' => '<h3>' . $this->t("Step 3: Growth Over Time") . '</h3>',
    ];

    $form['calculator']['num_years_container']['num_years'] = [
      '#type' => 'textfield',
      '#size' => 10,
      '#title' => $this->t('Years to Grow'),
      '#required' => TRUE,
      '#description' => $this->t("Length of time, in years, that you plan to save."),
      '#attributes' => [
        'class' => ['num-years', 'num-input'],
        'aria-labelledby' => ['num_years_label'],
        'novalidate' => '',
      ],
      '#prefix' => '<div class="calculator__form-input">',
      '#suffix' => '</div>',
    ];

    $form['calculator']['interest_rate_container'] = [
      '#prefix' => '<div class="calculator_step">',
      '#suffix' => '</div>',
      '#markup' => '<h3>' . $this->t("Step 4: Interest Rate") . '</h3>',
    ];

    $form['calculator']['interest_rate_container']['interest_rate'] = [
      '#type' => 'textfield',
      '#size' => 10,
      '#title' => $this->t('Estimated Interest Rate'),
      '#required' => TRUE,
      '#description' => $this->t("Your estimated annual interest rate."),
      '#attributes' => [
        'class' => ['interest-rate', 'ir-input', 'num-input'],
        'aria-labelledby' => ['interest_rate_label'],
        'novalidate' => '',
      ],
      '#prefix' => '<div class="calculator__form-input">',
      '#suffix' => '</div>',
    ];

    $form['calculator']['compound_interest_container'] = [
      '#prefix' => '<div class="calculator_step">',
      '#suffix' => '</div>',
      '#markup' => '<h3>' . $this->t("Step 5: Compound It") . '</h3>',
    ];

    $form['calculator']['compound_interest_container']['compound_interest'] = [
      '#type' => 'select',
      '#required' => FALSE,
      '#title' => $this->t('Compound Frequency'),
      '#description' => $this->t("Times per year that interest will be compounded."),
      '#attributes' => [
        'class' => ['compound-interest'],
      ],
      '#options' => [
        0 => $this->t('Annually'),
        1 => $this->t('Semiannually'),
        2 => $this->t('Monthly'),
        3 => $this->t('Daily'),
      ],
      '#default_value' => 0,
      '#prefix' => '<div class="calculator__form-input">',
      '#suffix' => '</div>',
    ];

    $form['calculator']['actions'] = [
      '#type' => 'actions',
      '#prefix' => '<div id="compound-calc__buttons" class="buttons">',
      '#suffix' => '</div>',
    ];

    $form['calculator']['actions']['errors'] = [
      '#prefix' => '<div id="savings-calc__errors" class="calc-errors">',
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
        'wrapper' => 'savings-calc-wrapper',
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
      '#prefix' => '',
      '#suffix' => '',
    ];

    $form['results'] = [
      '#type' => 'markup',
      '#prefix' => '<div tabindex="-1" aria-live="polite"><div id="results_container" class="results-container element-invisible"><div class="results-container__inner">
          <div id="calculator_results_chart" class="results_container__chart"></div>',
      '#suffix' => '</div></div></div>',
    ];

    return ['form' => $form];
  }

  /**
   * {@inheritdoc}
   */
  public function validateForm(array &$form, FormStateInterface $form_state) {

    $values = $form_state->getValues();

    $badSymbols = [',', '$', '%'];

    if (($values['end_amount']) && !is_numeric(str_replace($badSymbols, "", $values['end_amount']))) {
      $form_state->setErrorByName('end_amount', $this->t('Savings Goal field requires numbers only.'));
    }

    if (isset($values['end_amount']) && str_replace($badSymbols, "", $values['end_amount']) <= 0) {
      $form_state->setErrorByName('end_amount', $this->t('Savings Goal must be above zero.'));
    }

    if (isset($values['end_amount']) && str_replace($badSymbols, "", $values['end_amount']) > 999999999) {
      $form_state->setErrorByName('end_amount', $this->t('Savings Goal cannot be above $999,999,999.'));
    }

    if (($values['principal']) && !is_numeric(str_replace($badSymbols, "", $values['principal']))) {
      $form_state->setErrorByName('principal', $this->t('Initial Investment field requires numbers only.'));
    }

    if (isset($values['principal']) && str_replace($badSymbols, "", $values['principal']) <= 0) {
      $form_state->setErrorByName('principal', $this->t('Initial Investment must be above zero.'));
    }

    if (isset($values['principal']) && str_replace($badSymbols, "", $values['principal']) > 999999999) {
      $form_state->setErrorByName('principal', $this->t('Initial Investment cannot be above $999,999,999.'));
    }

    if (($values['num_years']) && !is_numeric(str_replace($badSymbols, "", $values['num_years']))) {
      $form_state->setErrorByName('num_years', $this->t('Years to Grow field requires numbers only.'));
    }

    if (isset($values['num_years']) && str_replace($badSymbols, "", $values['num_years']) <= 0) {
      $form_state->setErrorByName('num_years', $this->t('Years to Grow must be above zero.'));
    }

    if (isset($values['num_years']) && str_replace($badSymbols, "", $values['num_years']) > 100) {
      $form_state->setErrorByName('num_years', $this->t('Years to Grow cannot be above 100.'));
    }

    if (($values['interest_rate']) && !is_numeric(str_replace($badSymbols, "", $values['interest_rate']))) {
      $form_state->setErrorByName('interest_rate', $this->t('Interest Rate field requires numbers only.'));
    }

    if (($values['interest_rate']) && $values['interest_rate'] <= 0) {
      $form_state->setErrorByName('interest_rate', $this->t('Interest Rate field must be above zero.'));
    }

    if (isset($values['interest_rate']) && $values['interest_rate'] >= 100) {
      $form_state->setErrorByName('interest_rate', $this->t('Interest Rate must be below 100%.'));
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
    if (!$form_state->getErrors()) {

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
      // Delete the settings array so that Highcharts doesn't try to render.
      $form['#attached']['drupalSettings']['sec_savings_calculator'] = [];
      $form_state->setRebuild();
      return $form;
    }
  }

  /**
   * Calculate savings goal.
   */
  public function calculateResult(array &$form, FormStateInterface $form_state) {

    $badSymbols = [',', '$', '%'];
    $hasVar = TRUE;

    $values = $form_state->getValues();

    $interestRate = str_replace($badSymbols, "", ($values['interest_rate'] / 100));

    // Number of years compounded.
    $numYears = $values['num_years'];

    // Amount added each month.
    $principal = str_replace($badSymbols, "", $values['principal']);

    // Savings goal.
    $finalValueTotal = str_replace($badSymbols, "", $values['end_amount']);

    if ($values['compound_interest'] == 0) {
      $compoundsPerYear = (1 * 1);
    }
    elseif ($values['compound_interest'] == 1) {
      $compoundsPerYear = (2 * 1);
    }
    elseif ($values['compound_interest'] == 2) {
      $compoundsPerYear = (12 * 1);
    }
    elseif ($values['compound_interest'] == 3) {
      $compoundsPerYear = (365 * 1);
    }


    // Interest rates divided by how many times compounded per year.
    // M = iP/[q([1+(i/q)]^nq - 1)]
    $iRateDivCompound = ($interestRate / $compoundsPerYear);

    // Total number of compounds.
    $totalCompounds = ($compoundsPerYear * $numYears);

    //Figure out Month Total.
    $newPrincipal = $principal * (pow((1 + $iRateDivCompound), $totalCompounds));

    $finalMinusPrincipal = $finalValueTotal - $newPrincipal;
    $dividedPerMonth = ((pow((1 + $iRateDivCompound), $totalCompounds) - 1) / ($interestRate / $compoundsPerYear));
    $perMonthAddition = ($finalMinusPrincipal / $dividedPerMonth) / (12 / $compoundsPerYear);

    //Get compound interest on total.
    $compounded_principal = $principal; // Principal amount
    $total_value[] = (float) $compounded_principal; // array containing yearly totals

    for ($x = 0; $x < $numYears; $x++) {
      //Calculate Monthly Amount.
      // How much added each year.
      $perMonthTotal = (($perMonthAddition * 12) / $compoundsPerYear);
      //Calculate compound interest on monthly additions.
      $cont_valA = (pow((1 + ($interestRate / $compoundsPerYear)), $compoundsPerYear) - 1);
      $cont_val = ($cont_valA / ($interestRate / $compoundsPerYear));

      $finalValueAccrued = ($perMonthTotal * $cont_val);

      $compounded_principal = $compounded_principal * (pow((1 + ($interestRate / $compoundsPerYear)), $compoundsPerYear));
      $compounded_principal = $compounded_principal + $finalValueAccrued;

      $total_value[] = round($compounded_principal, 2);
    }

    //get compound interest on base
    $compounded_base = $principal;
    $base_value[] =(float)  $compounded_base;
    for ($x = 0; $x < $numYears; $x++) {

      $compounded_base = $compounded_base * (pow((1 + ($interestRate / $compoundsPerYear)), $compoundsPerYear));
      $base_value[] = round($compounded_base, 2);
    }

    //get compound interest on monthly totals
    $compounded_monthly = 0;
    $monthly_value[] = (float) $compounded_monthly;
    for ($x = 0; $x < $numYears; $x++) {
      //Calculate Monthly Amount
      $perMonthTotal = (($perMonthAddition * 12) / $compoundsPerYear); // How much added each year
      //Calculate compound interest on monthly additions
      $cont_valA = (pow((1 + ($interestRate / $compoundsPerYear)), $compoundsPerYear) - 1);
      $cont_val = ($cont_valA / ($interestRate / $compoundsPerYear));

      $finalValueAccrued = ($perMonthTotal * $cont_val);

      //$compounded_monthly = $compounded_monthly * (pow((1 + ($interestRate / $compoundsPerYear)), $compoundsPerYear));
      $compounded_monthly = ($compounded_monthly + $finalValueAccrued);
      $monthly_value[] = round($compounded_monthly, 2);
    }

    $total_years = array();
    for($x = 0; $x <= $numYears; $x++) {
      $yearly_totals[] = $total_value[$x];
      $base_totals[] = $base_value[$x];
      $monthly_totals[] = $monthly_value[$x];
      array_push($total_years, ('Year ' . $x));
    };

    $final_amount[] =  $yearly_totals;
    $final_base[] = $base_totals;
    $final_monthly[] = $monthly_totals;

    $js_settings = [
      'variable' => $dividedPerMonth,
      'calcType' => 'monthly',
      'monthlyResults' => $final_monthly[0],
      'monthTotal' => $perMonthAddition,
      'calcResults' => $final_amount[0],
      'baseResults' => $final_base[0],
      'calcYears' => $total_years,
    ];

    $markup = '<h2> ' . $this->t('The Results Are In') . '</h2>';
    $markup .= '<h3 class="calculator__results-amount">' . $this->t('If you contribute <span class="amount">$@perMonthAddition</span> every month over the next <span class="amount">@numYears</span> years towards your goal, you will have <span class="amount">$@finalValueTotal</span> in savings.</h3>', [
      '@perMonthAddition' => number_format($perMonthAddition, 2, '.', ','),
      '@numYears' => $numYears,
      '@finalValueTotal' => number_format($finalValueTotal, 2, '.', ',')
    ]);
    $markup .= '<p class="calculator__results-note">' . $this->t('Please remember that slight adjustments in any of the variables can affect the outcome. Reset the calculator and provide different figures to show different scenarios.') . '</p>';

    $results = [];
    $results['#prefix'] = '<div id="results_container" class="results-container"><div class="results-container__inner">';
    $results['#suffix'] = '<div id="calculator_results_chart" class="results_container__chart" width="400" ></div><div id="calculator_results_table" class="results_container__table" width="400" ></div></div>';
    $results['#markup'] = $markup;
    $results['#attached']['drupalSettings']['sec_savings_calculator'] = $js_settings;

    return $results;
  }

}
