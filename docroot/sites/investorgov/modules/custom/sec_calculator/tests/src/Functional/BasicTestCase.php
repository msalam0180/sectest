<?php

namespace Drupal\Tests\sec_calculator\Functional;

use Drupal\Tests\BrowserTestBase;

/**
 * Test basic functionality of SEC Calendar.
 *
 * @group sec_calculator
 */
class BasicTestCase extends BrowserTestBase {
  /**
   * {@inheritdoc}
   */
  public static $modules = [
    // Module(s) for core functionality.
    'node',
    'views',

    // This module.
    'sec_calculator',
  ];

  /**
   * {@inheritdoc}
   */
  protected function setUp() {
    // Make sure to complete the normal setup steps first.
    parent::setUp();

    // Set the front page to "node".
    \Drupal::configFactory()
      ->getEditable('system.site')
      ->set('page.front', '/node')
      ->save(TRUE);
  }

  /**
   * Make sure the site loads with the module enabled.
   */
  public function smokeTest() {
    // Load the front page.
    $this->drupalGet('<front>');

    // Confirm that the site didn't throw a server error or something else.
    $this->assertSession()->statusCodeEquals(200);

    // Confirm that the front page contains the site name.
    $this->assertText($this->t('Investor.gov'));
  }

}
