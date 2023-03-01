<?php

/**
 * Implements hook_views_data_alter().
 */

function sec_view_filter_plugin_views_data_alter(array &$data) 
{
    $data['node_field_data']['year'] = [
    'title' => t('Custom Year'),
    'filter' => [
        'title' => t('Custom Year filter (Published date)'),
        'help' => t('Filters nodes on given Year (*Requires relationship with field_publish_date)'),
        'field' => 'field_date_value',
        'id' => 'sec_year_filter'
    ],
    ];

    $data['node_field_data']['month'] = [
    'title' => t('Custom Month'),
    'filter' => [
        'title' => t('Custom Month filter (Published date)'),
        'help' => t('Filters nodes on given Month (*Requires relationship with field_publish_date)'),
        'field' => 'field_date_value',
        'id' => 'sec_month_filter'
    ],
    ];

    $data['node_field_data']['sec_seasonal_field'] = [
      'title' => t('Grouped by seasons'),
      'group' => t('Content'),
      'field' => [
          'title' => t('Seasonal grouping'),
          'help' => t('Group content by seasons.'),
          'id' => 'sec_field_publish_date_seasonal',
      ],
    ];

    $data['node_field_data']['sec_publish_date_field'] = [
        'title' => t('Grouped by Published date'),
        'group' => t('Content'),
        'field' => [
            'title' => t('Published date grouping'),
            'help' => t('Group content by published date.'),
            'id' => 'sec_field_publish_date',
        ],
    ];

    $data['node_field_data']['article_type'] = [
        'title' => t('Article Type'),
        'filter' => [
            'title' => t('Custom Article Type filter'),
            'help' => t('Filters nodes on selected Article-Type value'),
            'field' => 'title',
            'id' => 'sec_articleType_filter'
        ],
    ];


    $data['node_field_data']['person'] = [
        'title' => t('Person'),
        'filter' => [
            'title' => t('Custom Person filter'),
            'help' => t('Filters nodes on selected Person value'),
            'field' => 'title',
            'id' => 'sec_person_filter'
        ],
    ];

    $data['node_field_data']['news_type'] = [
    'title' => t('News Type'),
    'filter' => [
      'title' => t('Custom News Type filter'),
      'help' => t('Filters nodes on selected News Type value'),
      'field' => 'title',
      'id' => 'sec_newsType_filter'
    ],
    ];
}
