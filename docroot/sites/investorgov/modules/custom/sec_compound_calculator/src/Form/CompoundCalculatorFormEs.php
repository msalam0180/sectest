<?php

namespace Drupal\sec_compound_calculator\Form;

use Drupal\Core\Ajax\AjaxResponse;
use Drupal\Core\Ajax\ReplaceCommand;
use Drupal\Core\Ajax\ChangedCommand;
use Drupal\Core\Form\FormStateInterface;
use Drupal\Core\Ajax\AfterCommand;
use Drupal\Core\Ajax\BeforeCommand;
use Drupal\Core\Ajax\InvokeCommand;
use Drupal\Core\Ajax\RemoveCommand;
use Drupal\Core\Ajax\CssCommand;

/**
 * Form for Compound Interest Calculator.
 */
class CompoundCalculatorFormEs extends CompoundCalculatorAbstractForm {

  /**
   * {@inheritdoc}
   */
  public function getFormId() {
    return 'compound_calculator_form_es';
  }

  /**
   * {@inheritdoc}
   */
  public function buildForm(array $form, FormStateInterface $form_state) {
    // Attach JS.
    $form['#attached']['library'][] = 'sec_calculator/sec_calculator';
    $form['#attached']['library'][] = 'sec_compound_calculator/sec_spanish_compound_calculator';

    // Don't cache the form.
    $form['#cache'] = ['max-age' => 0];

    $form['#attributes']['class'] = ['sec_calculator_form'];
    // Disable HTML5 browser validation, which confuses screen readers.
    $form['#attributes']['novalidate'] = 'novalidate';

    $form['#prefix'] = '<div id="compound-interest-calc-wrapper"><p class="form-required"><strong>EL <span>*</span> INDICA QUE EL CAMPO ES OBLIGATORIO</strong></p><div class="sec-calculator" id="compound-interest-calc">';
    $form['#suffix'] = '</div></div>';

    $form['calculator'] = [
      '#type' => 'container',
      '#prefix' => '<div class="calculator"><h2 class="element-invisible">Calculadora</h2>',
      '#suffix' => '</div>',
      '#attributes' => ['id' => 'calculator_wrapper', 'class' => 'calculator_wrapper'],
    ];

    $form['calculator']['principal_container'] = [
      '#prefix' => '<div class="calculator_step">',
      '#suffix' => '</div>',
      '#markup' => '<h3>' . $this->t("Paso 1: Inversión inicial") . '</h3>',
    ];

    $form['calculator']['principal_container']['principal'] = [
      '#type' => 'textfield',
      '#size' => 10,
      '#title' => $this->t('Inversión inicial'),
      '#required' => TRUE,
      '#description' => $this->t("Monto de dinero que tiene disponible para invertir inicialmente."),
      '#attributes' => [
        'class' => ['monetary-input', 'num-input'],
        'aria-labelledby' => ['principal_label'],
        'novalidate' => '',
      ],
      '#prefix' => '<div class="calculator__form-input">',
      '#suffix' => '</div>',
    ];

    $form['calculator']['contribute_container'] = [
      '#prefix' => '<div class="calculator_step">',
      '#suffix' => '</div>',
      '#markup' => '<h3>' . $this->t("Paso 2: Contribución") . '</h3>',
    ];

    $form['calculator']['contribute_container']['addition'] = [
      '#type' => 'textfield',
      '#size' => 10,
      '#title' => $this->t('Contribución mensual'),
      '#required' => FALSE,
      '#description' => $this->t("Monto que tiene previsto agregar al capital cada mes, o un número negativo para el monto que tiene previsto extraer cada mes."),
      '#attributes' => [
        'class' => ['monetary-input', 'neg-input'],
        'aria-labelledby' => ['addition_label'],
        'novalidate' => '',
      ],
      '#prefix' => '<div class="calculator__form-input">',
      '#suffix' => '</div>',
    ];

    $form['calculator']['contribute_container']['num_years'] = [
      '#type' => 'textfield',
      '#size' => 10,
      '#title' => $this->t('Cantidad de tiempo en años'),
      '#required' => TRUE,
      '#description' => $this->t("Cantidad de tiempo, en años, que tiene previsto ahorrar."),
      '#attributes' => [
        'class' => ['num-years', 'num-input', 'fractional-num-year'],
        'aria-labelledby' => ['num_years_label'],
        'novalidate' => '',
      ],
      '#prefix' => '<div class="calculator__form-input">',
      '#suffix' => '</div>',
    ];

    $form['calculator']['interest_rate_container'] = [
      '#prefix' => '<div class="calculator_step">',
      '#suffix' => '</div>',
      '#markup' => '<h3>' . $this->t("Paso 3: Tasa de interés") . '</h3>',
    ];

    $form['calculator']['interest_rate_container']['interest_rate'] = [
      '#type' => 'textfield',
      '#size' => 10,
      '#title' => $this->t('Tasa de interés estimada'),
      '#required' => TRUE,
      '#description' => $this->t("Su tasa de interés anual estimada."),
      '#attributes' => [
        'class' => ['interest-rate', 'ir-input', 'num-input'],
        'aria-labelledby' => ['interest_rate_label'],
        'novalidate' => '',
      ],
      '#prefix' => '<div class="calculator__form-input">',
      '#suffix' => '</div>',
    ];

    $form['calculator']['interest_rate_container']['interest_rate_variance'] = [
      '#type' => 'textfield',
      '#size' => 10,
      '#title' => $this->t('Rango de varianza de las tasas de interés'),
      '#required' => FALSE,
      '#description' => $this->t("Rango de tasas de interés (por encima y por debajo de la tasa establecida anteriormente) para las cuales desea ver los resultados."),
      '#attributes' => [
        'class' => ['interest-rate', 'ir-input', 'num-input'],
        'aria-labelledby' => ['interest_variance_label'],
        'novalidate' => '',
      ],
      '#prefix' => '<div class="calculator__form-input">',
      '#suffix' => '</div>',
    ];

    $form['calculator']['compound_interest_container'] = [
      '#prefix' => '<div class="calculator_step">',
      '#suffix' => '</div>',
      '#markup' => '<h3>' . $this->t("Paso 4: Capitalización") . '</h3>',
    ];

    $form['calculator']['compound_interest_container']['compound_interest'] = [
      '#type' => 'select',
      '#required' => FALSE,
      '#title' => $this->t('Frecuencia de capitalización'),
      '#description' => $this->t("Cantidad de veces por año que se capitalizará el interés."),
      '#attributes' => [
        'class' => ['compound-interest'],
      ],
      '#options' => [
        0 => $this->t('Anualmente'),
        1 => $this->t('Semestralmente'),
        2 => $this->t('Trimestral'),
        3 => $this->t('Mensualmente'),
        4 => $this->t('Diariamente'),
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
      '#prefix' => '<div id="compound-calc__errors" class="calc-errors">',
      '#suffix' => '</div>',
    ];

    $form['calculator']['actions']['submit'] = [
      '#type' => 'submit',
      '#value' => $this->t('CALCULAR'),
      '#attributes' => [
        'class' => ['submit'],
        'role' => ['button'],
      ],
      '#ajax' => [
        'callback' => [$this, 'submitCallback'],
        'wrapper' => 'compound-interest-calc-wrapper',
        'progress' => [
          'type' => 'throbber',
          'message' => $this->t('Calcular...'),
        ],
      ],
    ];

    $form['calculator']['actions']['reset'] = [
      '#type' => 'button',
      '#button_type' => 'reset',
      '#value' => $this->t('RESTABLECER'),
      '#prefix' => '',
      '#suffix' => '',
    ];

    $form['results'] = [
      '#type' => 'markup',
      '#prefix' => '<div aria-live="polite" tabindex="-1"><div id="results_container" class="results-container element-invisible">
        <div class="results-container__inner">
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

    if (isset($values['principal']) && !is_numeric(str_replace($badSymbols, "", $values['principal']))) {
      $form_state->setErrorByName('principal', $this->t('En “Capital” puede ingresar números únicamente.'));
    }

    if (isset($values['principal']) && str_replace($badSymbols, "", $values['principal']) > 999999999) {
      $form_state->setErrorByName('principal', $this->t('El capital no puede superar el monto de $999,999,999.'));
    }

    if (isset($values['principal']) && str_replace($badSymbols, "", $values['principal']) < -999999999) {
      $form_state->setErrorByName('principal', $this->t('El capital no puede ser inferior al monto de -$999,999,999.'));
    }

    if (isset($values['num_years']) && !is_numeric(str_replace($badSymbols, "", $values['num_years']))) {
      $form_state->setErrorByName('num_years', $this->t('En “Cantidad de años” puede ingresar números únicamente.'));
    }

    if (isset($values['num_years']) && $values['num_years'] < 1) {
      $form_state->setErrorByName('num_years', $this->t('La cantidad de años debe ser de 1 o más.'));
    }

    if (isset($values['num_years']) && $values['num_years'] > 100) {
      $form_state->setErrorByName('num_years', $this->t('La cantidad de años debe ser menor que 100.'));
    }

    if (isset($values['interest_rate']) && !is_numeric(str_replace($badSymbols, "", $values['interest_rate']))) {
      $form_state->setErrorByName('interest_rate', $this->t('En “Tasa de interés” puede ingresar números únicamente.'));
    }

    if (isset($values['interest_rate']) && $values['interest_rate'] <= 0) {
      $form_state->setErrorByName('interest_rate', $this->t('La tasa de interés debe ser mayor que cero.'));
    }

    if (isset($values['interest_rate']) && $values['interest_rate'] >= 100) {
      $form_state->setErrorByName('interest_rate', $this->t('La tasa de interés debe ser inferior al 100 %.'));
    }
  }

  /**
   * Build error message markup.
   */
  public function buildErrorMsgMarkup($errors) {
    $requiredFields = [
      'principal' => 'Inversión inicial',
      'num_years' => 'Cantidad de tiempo en años',
      'interest_rate' => 'Tasa de interés estimada',
    ];

    $errorsList = '';
    foreach ($errors as $field => $errorMsg) {
      $fieldElement = str_replace('_', '-', $field);
      $errorsList .= '<li><a href="#edit-' . $fieldElement . '">' .
        $requiredFields[$field] . '</a></li>';
    }

    return '<div data-drupal-message>' .
      '<div role="contentinfo" aria-label="Se encontraron erroes" class="messages messages--error">' .
      '<div role="alert">' .
      '<h2 class="visually-hidden">Se encontraron </h2>' .
      count($errors) . ' errores:' .
      ' <ul class="item-list__comma-list">' . $errorsList . '</ul>' .
      '</div>' .
      '</div>' .
      '</div>';
  }

  /**
   * Calculate compound interest.
   */
  public function calculateResult(array &$form, FormStateInterface $form_state): array {

    $badSymbols = [',', '$', '%'];
    $hasVar = TRUE;

    $values = $form_state->getValues();

    $interestRate = str_replace($badSymbols, "", ($values['interest_rate'] / 100));
    $initialVariance = is_numeric($values['interest_rate_variance']) ? str_replace($badSymbols, "", ($values['interest_rate_variance'] / 100)) : 0;

    // User entered number of years compounded value.
    $numYearsValue = $values['num_years'];

    // Get the number of years and the fractional year value.
    $fractionalValues = explode('.', $numYearsValue);
    $numYears = $fractionalValues[0];
    $fractionalYear = $numYearsValue - $numYears;

    if ($fractionalYear) {
      // Add additional year in the table if it contains fractional year.
      $numYears = $numYears + 1;
      // Convert fractional values to number of months in a year.
      $fractionalYearContribution = $fractionalYear * 12;
    }

    // Amount added each month.
    $monthlyAddition = (int) str_replace($badSymbols, "", $values['addition']);

    if ($values['compound_interest'] == 0) {
      // Annually
      $compoundsPerYear = (1 * 1);
    } elseif ($values['compound_interest'] == 1) {
      // Semi Annually
      $compoundsPerYear = (2 * 1);
    } elseif ($values['compound_interest'] == 2) {
      // Quarterly
      $compoundsPerYear = (4 * 1);
    } elseif ($values['compound_interest'] == 3) {
      // Monthly
      $compoundsPerYear = (12 * 1);
    } elseif ($values['compound_interest'] == 4) {
      // Daily
      $compoundsPerYear = (365 * 1);
    }

    $principal = str_replace($badSymbols, "", $values['principal']);

    if ($initialVariance > 0 && isset($initialVariance)) {
      $iRateVarPlus = ($interestRate + $initialVariance);
      $iRateVarMinus = ($interestRate - $initialVariance);
    } else {
      $iRateVarPlus = 0;
      $iRateVarMinus = 0;
      $hasVar = FALSE;
    }

    // Interest rates divided by how many times compounded per year.
    $iRateDivCompound = ($interestRate / $compoundsPerYear);

    // Fix when rate is 0
    $iRatePlusDivCompound = $iRateVarPlus != 0 ? ($iRateVarPlus / $compoundsPerYear) : 0;
    $iRateMinusDivCompound = $iRateVarMinus != 0 ? ($iRateVarMinus / $compoundsPerYear) : 0;
    $baseRateNoCompound = 0;

    // Calculations for base interest rate.
    $compound_rate_array = [
      0 => $iRateDivCompound,
      1 => $iRatePlusDivCompound,
      2 => $iRateMinusDivCompound,
      3 => $baseRateNoCompound,
    ];

    $final_amount = [];
    $total_years = [];
    $yearly_totals = [];

    foreach ($compound_rate_array as $key => $rate) {
      // Principal amount.
      $compounded_principal = (float) $principal;
      // Array containing yearly totals.
      $total_value[] = $compounded_principal;

      for ($x = 0; $x < $numYears; $x++) {
        // Calculate Monthly Amount.
        if ($key == 3 || $rate == 0) {
          $perMonthTotalInYear = $monthlyAddition * 12;
        } else {
          // How much added each year.
          $perMonthTotalInYear = ($monthlyAddition * 12) / $compoundsPerYear;
        }

        // Calculate compound interest on monthly additions.
        // Do this only when the interest rate is not zero.
        if ($rate != 0) {
          $cont_valA = (pow((1 + $rate), $compoundsPerYear) - 1);
          $cont_val = ($cont_valA / $rate);
        } else {
          $cont_val = 0;
        }

        if ($cont_val != 0) {
          $finalValueAccrued = ($perMonthTotalInYear * $cont_val);
        } else {
          $finalValueAccrued = $perMonthTotalInYear;
        }

        if (isset($fractionalYearContribution) && ($x == $numYears - 1)) {
          // (1+i/n)exp(nt), i/n is $value, nt is number of years x compound per year.
          $compounded_interest = pow((1 + $rate), ($numYearsValue * $compoundsPerYear));
          // P(1+i/n)ext(nt)
          $compound_principal = (float) $principal * $compounded_interest;
          // PMT[(1+i/n)ext(nt) -1]/(i/n)
          if ($rate == 0) {
            $compounded_principal = $compounded_principal + $monthlyAddition  * $fractionalYearContribution;
          } else {
            $compound_monthly = $perMonthTotalInYear * ($compounded_interest - 1) / $rate;
            $compounded_principal = $compound_principal + $compound_monthly;
          }
        } else {
          $compounded_principal = $compounded_principal * (pow((1 + $rate), $compoundsPerYear));
          $compounded_principal = $compounded_principal + $finalValueAccrued;
        }

        $total_value[] = round($compounded_principal, 2);
      }
      for ($x = 0; $x <= $numYears; $x++) {
        $yearly_totals[] = $total_value[$x];
      };
      $final_amount[] = $yearly_totals;
      $finalResult = end($final_amount[0]);
      unset($compounded_principal, $total_value, $yearly_totals);
    }

    for ($x = 0; $x <= $numYears; $x++) {
      array_push($total_years, ('Año ' . $x));
    };

    $js_settings = [
      'calcType' => 'basic',
      'calcResults' => $final_amount[0],
      'calcResultsPlus' => $final_amount[1],
      'calcResultsMinus' => $final_amount[2],
      'calcResultsBase' => $final_amount[3],
      'calcYears' => $total_years,
      'interestRateBase' => $interestRate,
      'interestRatePlus' => $iRateVarPlus,
      'interestRateMinus' => $iRateVarMinus,
      'hasVar' => $hasVar,
    ];

    $markup = '<h2> ' . $this->t('Resultados') . '</h2>';
    $markup .= '<h3 class="calculator__results-amount">' . $this->t('En <span class="amount">@numYears</span> años, tendrá <span class="amount">$@finalResult</span>', ['@numYears' => $numYearsValue, '@finalResult' => number_format($finalResult, 2, '.', ',')]) . '</h3>';
    $markup .= '<p class="calculator__results-note">' . $this->t('La siguiente tabla muestra una estimación de cuánto crecerán sus ahorros iniciales en el tiempo, según la tasa de interés y el cronograma de capitalización que especificó.') . '</p>';
    $markup .= '<p class="calculator__results-note">' . $this->t('Recuerde que ciertos pequeños ajustes de cualquiera de esas variables pueden afectar el resultado. Restablezca la calculadora e ingrese cifras diferentes para que se muestren las diferentes situaciones.') . '</p>';

    $results = [];
    $results['#prefix'] = '<div id="results_container" class="results-container">
      <div class="results-container__inner">';
    $results['#suffix'] = '<div id="calculator_results_chart" class="results_container__chart" width="400" ></div><div id="calculator_results_table" class="results_container__table" width="400" ></div></div>';
    $results['#markup'] = $markup;
    $results['#attached']['drupalSettings']['sec_compound_calculator'] = $js_settings;

    return $results;
  }
}
