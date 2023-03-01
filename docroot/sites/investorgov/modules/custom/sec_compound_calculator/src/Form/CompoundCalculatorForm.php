<?php

namespace Drupal\sec_compound_calculator\Form;

/**
 * Form for Compound Interest Calculator.
 */
class CompoundCalculatorForm extends CompoundCalculatorAbstractForm {

  /**
   * {@inheritdoc}
   */
  public function getFormId() {
    return 'compound_calculator_form';
  }

}
