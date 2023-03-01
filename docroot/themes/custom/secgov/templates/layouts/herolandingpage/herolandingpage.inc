<?php

/**
 * implementation of hook_panels_layouts()
 */
// Plugin definition
$plugin = array(
  'title' => t('Hero Landing Page'),
  'category' => t('Columns: 1'),
  'icon' => 'herolandingpage.png',
  'theme' => 'panels_herolandingpage',
  'css' => 'herolandingpage.css',
  'regions' => array(
  	'hero' -> t('Hero'),
    'alert' -> t('Alert'),
  	'section_1_title' -> t('Section 1, Title'),
    'section_1_left' => t('Section 1, Left'),
    'section_1_right' -> t('Section 1, Right'),
  	'section_2_title' -> t('Section 2, Title'),
    'section_2_left' => t('Section 2, Left'),
    'section_2_right' -> t('Section 2, Right'),
  	'section_3_title' -> t('Section 3, Title'),
    'section_3_left' => t('Section 3, Left'),
    'section_3_right' -> t('Section 3, Right'),
  	'section_4_title' -> t('Section 4, Title'),
    'section_4_left' => t('Section 4, Left'),
    'section_4_right' -> t('Section 4, Right'),
  	'section_5_title' -> t('Section 5, Title'),
    'section_5_left' => t('Section 5, Left'),
    'section_5_right' -> t('Section 5, Right'),
    'section_6_title' -> t('Section 6, Title'),
    'section_6_left' => t('Section 6, Left'),
    'section_6_right' -> t('Section 6, Right'),
  ),
);
