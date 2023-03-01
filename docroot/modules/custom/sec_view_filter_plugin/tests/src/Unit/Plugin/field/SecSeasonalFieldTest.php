<?php

/**
 * @file
 * Contains \Drupal\Tests\sec_view_filter_plugin\Unit\Plugin\field.
 */

namespace Drupal\Tests\sec_view_filter_plugin\Unit\Plugin\field;

use Drupal\Tests\UnitTestCase;
use Drupal\sec_view_filter_plugin\Plugin\views\field\SecSeasonalField;

/**
 * @coversDefaultClass \Drupal\sec_view_filter_plugin\Plugin\views\field\SecSeasonalField
 * @group sec
 * @group sec_view_filter_plugin
 */
class SecSeasonalFieldTest extends UnitTestCase
{

    /**
     * The SecActivitySubscriber instance.
     *
     * @var \Drupal\sec_view_filter_plugin\Plugin\views\field\SecSeasonalField
     */
    private $_secSeasonalField;
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
            'title' => t('Grouped by Published date'),
            'group' => t('Content'),
            'field' => [
                'title' => t('Published date grouping'),
                'help' => t('Group content by published date.'),
                'id' => 'sec_field_publish_date',
            ],
        ];
        $this->_secSecSeasonalField = new SecSeasonalField([], 'sec_field_publish_date', $plugin_definition);
        $this->_resultRow = $this->getMockBuilder('Drupal\views\ResultRow')
            ->getMock();
    }

    /**
     * @covers ::query
     */
    public function testQueryReturnsNothing() 
    {
        $this->assertEquals(null, $this->_secSeasonalField->query());
    }

    /**
     * @covers ::render
     */
    public function testRender() 
    {
        $this->markTestIncomplete();
    }
}
