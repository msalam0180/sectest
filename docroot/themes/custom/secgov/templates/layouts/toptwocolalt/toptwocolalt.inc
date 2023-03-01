<?php

// Plugin definition
$plugin = array(
  'title' => t('Two column (9/3)'),
  'category' => t('Columns: 2'),
  'icon' => 'toptwocolalt.png',
  'theme' => 'panels_twocol',
  'css' => 'twocol.css',
  'regions' => array(
  	'top' => t('Top Page Title'),
    'left' => t('Left side'),
    'right' => t('Right side')
  ),
);
