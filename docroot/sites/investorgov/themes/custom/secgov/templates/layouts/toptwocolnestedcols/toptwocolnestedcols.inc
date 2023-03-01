<?php

// Plugin definition
$plugin = array(
  'title' => t('Nested, Two column'),
  'category' => t('Columns: 2'),
  'icon' => 'twocolnestedcols.png',
  'theme' => 'panels_twocol',
  'css' => 'twocol.css',
  'regions' => array(
  	'top' -> t('Top Page Title'),
    'left' => t('Left side'),
    'maintop' -> t('Main Column, Top Section'),
    'mainleft' => t('Main Column, Leftide Section'),
    'mainright' => t('Main Column, Right Section'),
    'mainbottom' => t('Main Column, Bottom Section'),
    'sidebar' => t('Sidebar')
  ),
);
