<?php

use Drupal\taxonomy\Entity\Term;

/**
 * @file
 * Page hook implementations.
 */

/**
 * Implements hook_preprocess_page().
 */
function uswdssec_preprocess_page(&$variables) {

  // Setting the default sidebar menu that appears using the $variables['sidebarMenu'] and page.twig.html
  if ($node = \Drupal::routeMatch()->getParameter('node')) {
    $type = $node->getType();

    $menuDetails = array();
    $menuDetails['Node Type'] = $type;
    
    if ($node->hasField('field_left_nav_override') && $overideMenu = $node->get('field_left_nav_override')->first()) {

      // left_nav_override
      $overideMenu = $overideMenu->getValue()['target_id'];

      if (isset($overideMenu) && !empty($overideMenu)) {
        if ($overideMenu == 'no-menu') {
          $variables['sidebarMenu'] == NULL;
        } else {
          $variables['sidebarMenu'] = $overideMenu;
          $menuDetails['Overide Menu Field'] = $overideMenu;
          $menuDetails['Menu Is Set Via'] = 'Overide Menu Field';
        }
      }
    } elseif ($type == "secperson") {
      // if field_position_history_paragraph
      // TODO: do we even need this? - it seems that secpeople are all using about or overwriting the menu
      if ($node->hasField("field_position_history_paragraph")){
        $position_history_paragraph = $node->get('field_position_history_paragraph');
        foreach ($position_history_paragraph->referencedEntities() as $position) {
          $current_position = $position->field_current_position->value;
          if ($position->field_current_position->value == 1) {
            $position_category = $position->field_position_category->value;
            if ($position_category != 'Other') {
              $variables['sidebarMenu'] = 'about';
              $menuDetails['Menu Is Set Via'] = 'Secperson not "Other"';
            }
          }
        }
      }

    } elseif ($type == "secarticle") {
      
      if ($node->hasField("field_article_type_secarticle")){
        $articleType = $node->field_article_type_secarticle->entity->getTitle();
        $menuDetails['Article Type'] = $articleType;
      }

      if ($node->hasField("field_article_sub_type_secart")){
        $articleSubType = $node->field_article_sub_type_secart->value;
        $menuDetails['Article Sub Type'] = $articleSubType;
      }

      if ($node->hasField("field_primary_division_office")){
        $divisionOffice_field = $node->get('field_primary_division_office')->target_id;
        if ($divisionOffice_field) {
          $term = Term::load($divisionOffice_field);
          if (isset($divisionOffice_field)) {
            $divisionOffice = $term->getName();
          }
          $menuDetails['Division Office'] = $divisionOffice;
        }
      }

      $defaultMenus = array(
        // ["menu", "articleType", "articleSubType", "divisionOffice"],
        ["newsroom-left-nav", "Agendas"],
        ["newsroom-left-nav", "Webcasts"],
        ["newsroom-left-nav", "Sunshine Act"],
        ["newsroom-left-nav", "Fact Sheets"],
        ["investor-information-menu", "Investor Alerts and Bulletins"],
        ["investor-information-menu", "Fast Answers"],
        ["investor-information-menu", "Reports and Publications", "Reports and Publications-InvestorPublications"],
        ["filings-menu", "Forms"],
        ["market-structure-left-nav", "Data", "Data-MarketStructure"],
        ["dera", "Data", "Data-MarketStatistics"],
        ["about", "Contact Information", NULL, 'Agency-Wide'],
        ["about", "Announcement", NULL, 'Agency-Wide'],
        ["about", "Education/Help/Guides/FAQs", NULL, 'Agency-Wide'],
        ["about", "Other", NULL, 'Agency-Wide'],
        ["about", "Laws"],
        ["about", "Data"],
        ["about", "Staff Papers", NULL, 'Agency-Wide'],
        ["about", "Reports and Publications", "Reports and Publications-Other", 'Agency-Wide'],
        ["about", "Reports and Publications", NULL, 'Agency-Wide'],
      );

      $currentPageDetails = [NULL, $articleType, $articleSubType, $divisionOffice];

      foreach ($defaultMenus as $menu) {
        if (
          ($currentPageDetails[1] == $menu[1] || $menu[1] == NULL) &&
          ($currentPageDetails[2] == $menu[2] || $menu[2] == NULL) &&
          ($currentPageDetails[3] == $menu[3] || $menu[3] == NULL)
          )
        {
          $variables['sidebarMenu'] = $menu[0];
          $menuDetails['Menu Is Set Via'] = '$defaultMenus Array (arbitrary menus based on field choices)';
          break;
        }
      }
    }
    if ($variables['sidebarMenu']){
      $menuDetails['sidebarMenu'] = $variables['sidebarMenu'];
      // uncomment to troubleshoot what sidebar menu is appearing
      // dump($menuDetails);
    }
  }
}