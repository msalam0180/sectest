<?php

 /**
 * Implements hook_views_data()
 */

function sec_activity_tracker_views_data() 
{
    // Define the return array.
    $data = [];

    // The outermost keys of $data are Views table names, which should usually
    // be the same as the hook_schema() table names.
    $data['sec_activity_tracker'] = [];

    // The value corresponding to key 'table' gives properties of the table
    $data['sec_activity_tracker']['table'] = [];
    $data['sec_activity_tracker']['table']['group'] = t('SEC activity tracker');
    $data['sec_activity_tracker']['table']['provider'] = 'sec_activity_tracker';

    $data['sec_activity_tracker']['table']['base'] = [
    // Identifier (primary) field in this table for Views.
    'field' => 'id',
    'title' => t('SEC Activity Tracker table'),

    'help' => t('SEC Activity Tracker table contains user sec activity content and can be related to nodes.'),
    'weight' => -10,
    ];

    $data['sec_activity_tracker']['table']['join'] = [
    'node_field_data' => [
        'left_field' => 'nid',
        'field' => 'nid',
    ],
    ];
    // Relate sec_activity_tracker to the node_field_data content
    $data['sec_activity_tracker']['nid'] = [
    'title' => t('Relate to Node Field Data table'),
    'help' => t('Relate SEC Activity Tracker content to the node content'),
    'field' => [
      'id' => 'numeric',
    ],
    'sort' => [
      'id' => 'standard',
    ],
    'filter' => [
      'id' => 'numeric',
    ],
    'argument' => [
      'id' => 'numeric',
    ],
    'relationship' => [
      'base' => 'node_field_data',
      'base field' => 'nid',
      'id' => 'standard',
      'label' => t('SEC Activity Tracker node'),
    ],
    ];

    $data['sec_activity_tracker']['id'] = [
    'title' => t('SEC Activity Tracker ID'),
    'help' => t('The primary key of the SEC Activity Tracker table.'),
    'field' => [
      'id' => 'standard',
      'click sortable' => true,
    ],
    'sort' => [
      'id' => 'standard',
    ],
    'filter' => [
      'id' => 'string',
    ],
    'argument' => [
      'id' => 'string',
    ],
    ];

    // Numeric field, exposed as a field, sort, filter, and argument.
    $data['sec_activity_tracker']['uid'] = [
    'title' => t('Users uid value.'),
    'help' => t(''),

    'field' => [
      'id' => 'numeric',
    ],
    'sort' => [
      'id' => 'standard',
    ],
    'filter' => [
      'id' => 'numeric',
    ],
    'argument' => [
      'id' => 'numeric',
    ],
    ];

    // Plain text field, exposed as a field, sort, filter, and argument.
    $data['sec_activity_tracker']['title'] = [
    'title' => t('title'),
    'help' => t('Content title.'),
    'field' => [
      'id' => 'standard',
    ],
    'sort' => [
      'id' => 'standard',
    ],
    'filter' => [
      'id' => 'string',
    ],
    'argument' => [
      'id' => 'string',
    ],
    ];
    // Plain text field, exposed as a field, sort, filter, and argument.
    $data['sec_activity_tracker']['type'] = [
    'title' => t('Content type.'),
    'help' => t('title.'),
    'field' => [
      'id' => 'standard',
    ],
    'sort' => [
      'id' => 'standard',
    ],
    'filter' => [
      'id' => 'string',
    ],
    'argument' => [
      'id' => 'string',
    ],
    ];
    // Plain text field, exposed as a field, sort, filter, and argument.
    $data['sec_activity_tracker']['name'] = [
    'title' => t('name'),
    'help' => t('User name.'),
    'field' => [
      'id' => 'standard',
    ],
    'sort' => [
      'id' => 'standard',
    ],
    'filter' => [
      'id' => 'string',
    ],
    'argument' => [
      'id' => 'string',
    ],
    ];
    // Plain text field, exposed as a field, sort, filter, and argument.
    $data['sec_activity_tracker']['role'] = [
    'title' => t('User role.'),
    'help' => t('role.'),
    'field' => [
      'id' => 'standard',
    ],
    'sort' => [
      'id' => 'standard',
    ],
    'filter' => [
      'id' => 'string',
    ],
    'argument' => [
      'id' => 'string',
    ],
    ];
    // Plain text field, exposed as a field, sort, filter, and argument.
    $data['sec_activity_tracker']['action'] = [
    'title' => t('action'),
    'help' => t('Users action.'),
    'field' => [
      'id' => 'standard',
    ],
    'sort' => [
      'id' => 'standard',
    ],
    'filter' => [
      'id' => 'string',
    ],
    'argument' => [
      'id' => 'string',
    ],
    ];
    // Plain text field, exposed as a field, sort, filter, and argument.
    $data['sec_activity_tracker']['division_office'] = [
    'title' => t('division_office'),
    'help' => t('Users division office.'),
    'field' => [
      'id' => 'standard',
    ],
    'sort' => [
      'id' => 'standard',
    ],
    'filter' => [
      'id' => 'string',
    ],
    'argument' => [
      'id' => 'string',
    ],
    ];

    // Numeric field, exposed as a field, sort, filter, and argument.
    $data['sec_activity_tracker']['created'] = [
    'title' => t('created'),
    'help' => t('Date content was created.'),
    'field' => [
      'id' => 'date',
      'click sortable' => true,
    ],
    'sort' => [
      'id' => 'date',
    ],
    'filter' => [
      'id' => 'date',
    ],
    'argument' => [
      'id' => 'string',
    ],
    ];

    // Numeric field, exposed as a field, sort, filter, and argument.
    $data['sec_activity_tracker']['changed'] = [
    'title' => t('changed'),
    'help' => t('Date content was changed.'),

    'field' => [
      'id' => 'date',
      'click sortable' => true,
    ],
    'sort' => [
      'id' => 'date',
    ],
    'filter' => [
      'id' => 'date',
    ],
    'argument' => [
      'id' => 'string',
    ],
    ];

    return $data;
}
