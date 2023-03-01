<?php

/**
 * @file
 * Contains \Drupal\Tests\sec_view_filter_plugin\Unit\Plugin\field.
 */

namespace Drupal\Tests\sec_view_filter_plugin\Unit\Plugin\field;

use Drupal\Tests\UnitTestCase;
use Drupal\sec_view_filter_plugin\Plugin\views\field\SecPublishedDateField;

/**
 * @coversDefaultClass \Drupal\sec_view_filter_plugin\Plugin\views\field\SecPublishedDateField
 * @group sec
 * @group sec_view_filter_plugin
 */
class SecPublishedDateFieldTest extends UnitTestCase
{

    /**
     * The SecActivitySubscriber instance.
     *
     * @var \Drupal\sec_view_filter_plugin\Plugin\views\field\SecPublishedDateField
     */
    private $_secPublishedDateField;
    protected $entityManager;
    protected $formatterPluginManager;
    protected $fieldTypePluginManager;
    private $_resultRow;

    /**
     * {@inheritdoc}
     */
    protected function setUp() 
    {
        $plugin_definition = [
            'title' => t('Grouped by seasons'),
            'group' => t('Content'),
            'field' => [
                'title' => t('Seasonal grouping'),
                'help' => t('Group content by seasons.'),
                'id' => 'sec_field_publish_date_seasonal',
            ],
        ];
        $this->_secPublishedDateField = new SecPublishedDateField([], 'sec_field_publish_date_seasonal', $plugin_definition);
        $this->_resultRow = $this->getMockBuilder('Drupal\views\ResultRow')
            ->getMock();
    }

    /**
     * @covers ::query
     */
    public function testQueryReturnsNothing() 
    {
        $this->assertEquals(null, $this->_secPublishedDateField->query());
    }

    /**
     * @covers ::render
     */
    public function testRender() 
    {
        $this->markTestIncomplete();
    }
}
