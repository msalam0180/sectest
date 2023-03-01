<?php

/**
 * @file
 * Contains \Drupal\Tests\sec_view_filter_plugin\Unit\Plugin\filter.
 */

namespace Drupal\Tests\sec_view_filter_plugin\Unit\Plugin\filter;

use Drupal\Tests\UnitTestCase;
use Drupal\sec_view_filter_plugin\Plugin\views\filter\ArticleTypeFilter;
use Symfony\Component\DependencyInjection\ContainerBuilder;

/**
 * @coversDefaultClass \Drupal\sec_view_filter_plugin\Plugin\views\filter\ArticleTypeFilter
 * @group sec
 * @group sec_view_filter_plugin
 */
class ArticleTypeFilterTest extends UnitTestCase
{

    protected $plugin;
    protected $entityManager;
    protected $languageManager;
    protected $formatterPluginManager;
    protected $fieldTypePluginManager;
    protected $container;
    protected $renderer;

    /**
     * {@inheritdoc}
     */
    /**
   * {@inheritdoc}
   */
    protected function setUp() 
    {
        parent::setUp();

        $this->entityManager = $this->createMock('Drupal\Core\Entity\EntityManagerInterface');
        $this->formatterPluginManager = $this->getMockBuilder('Drupal\Core\Field\FormatterPluginManager')
            ->disableOriginalConstructor()
            ->getMock();

        $this->fieldTypePluginManager = $this->createMock('Drupal\Core\Field\FieldTypePluginManagerInterface');
        $this->fieldTypePluginManager->expects($this->any())
            ->method('getDefaultStorageSettings')
            ->willReturn([]);
        $this->fieldTypePluginManager->expects($this->any())
            ->method('getDefaultFieldSettings')
            ->willReturn([]);

        $this->languageManager = $this->createMock('Drupal\Core\Language\LanguageManagerInterface');
        $this->renderer = $this->createMock('Drupal\Core\Render\RendererInterface');

        $this->container = new ContainerBuilder();
        $this->container->set('plugin.manager.field.field_type', $this->fieldTypePluginManager);
        \Drupal::setContainer($this->container);
    }

    /**
     * @covers ::query
     */
    public function testQueryReturnsParentQuery() 
    {
        $definition = [
        'entity_type' => 'test_entity',
        'field_name' => 'title'
        ];
        $this->value = 'test';
        $this->plugin = new ArticleTypeFilter([], 'field', $definition);
        $this->assertEquals(null, $this->plugin->query());
    }

    /**
   * @covers ::getArticleList
   */
    public function testgetArticleListReturnsArticleList() 
    {
        $this->markTestIncomplete("This test will require additional work.");
        $definition = [
        'entity_type' => 'test_entity',
        'field_name' => 'title'
        ];
        $this->plugin = new ArticleTypeFilter([], 'field', $definition);
        $this->assertEquals([], $this->plugin->getArticleList());
    }
}
