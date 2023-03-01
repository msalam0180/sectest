<?php

// Plugin definition
$plugin = array(
  'title' => t('Two column with One column Bottom'),
  'category' => t('Columns: 2'),
  'icon' => 'twocolonecolbottom.png',
  'theme' => 'panels_twocolonecolbottom',
  'css' => 'twocolonecolbottom.css',
  'regions' => array(
    'left' => t('Left side'),
    'right' => t('Right side'),
    'bottom' => t('Bottom'),
  ),
);
