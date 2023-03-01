<?php
namespace Drupal\sec_twigextensions\Twig;
use Drupal\Core\Datetime\DrupalDateTime;
use DateTimeZone;
use DateInterval;
/**
 * Provides the Kint debugging function within Twig templates.
 */
class SecExtension extends \Twig_Extension
{
    /**
   * {@inheritdoc}
   */
  public function getName() {
        return 'sec_extension';
  }

  /**
   * {@inheritdoc}
   */
  public function getFunctions() {
         return [
        new \Twig_SimpleFunction('renderMenu', [$this, 'renderMenu']),
         ];
  }

  /**
   * Generates a list of all Twig filters that this extension defines.
   */
  public function getFilters() {
         return [
        new \Twig_SimpleFilter('apdate', [$this, 'apDate']),
        new \Twig_SimpleFilter('standardDatetime', [$this, 'standardDatetime']),
        new \Twig_SimpleFilter('apTime', [$this, 'apTime']),
         new \Twig_SimpleFilter('timezoneDate', [$this, 'timezoneDate']),
        new \Twig_SimpleFilter('apDateMonthYear', [$this, 'apDateMonthYear']),
        new \Twig_SimpleFilter('regexReplace', [$this, 'regexReplace']),
         ];
  }

  /**
   * Formats a date in AP format.
   */
  public function apDate($timestamp) {
         if (!empty($timestamp)) {
            $date = $this->getTimeZoneAdjustedDateTime($timestamp, new DateTimeZone('America/New_York'));

            $month = $this->_getAPMonth($date);
            $day = $date->format("j");
            $year = $date->format("Y");

            return $month." ".$day.", ".$year;
             }
  }

  /**
   * Formats a time in AP format.
   */
  public function apTime($timestamp) {
        if (!empty($timestamp)) {
            $date = $this->getTimeZoneAdjustedDateTime($timestamp, new DateTimeZone('America/New_York'));

            return $date->format('g:i a T');
            }
  }

  /**
   * Formats a time to standard Datetime format.
   */
  public function standardDatetime($timestamp) {
    if (!empty($timestamp)) {
      $date = $this->getTimeZoneAdjustedDateTime($timestamp, new DateTimeZone('America/New_York'));

      return $date->format("Y-m-d");
    }
  }

  /**
   * Formats a date in AP format.
   */
  public function apDateMonthYear($timestamp) {
         if (!empty($timestamp)) {
            $date = $this->getTimeZoneAdjustedDateTime($timestamp, new DateTimeZone('America/New_York'));
            $month = $this->_getAPMonth($date);
            $year = $date->format("Y");

            return $month." ".$year;
             }
  }

  /**
   * Formats a Date Time in AP format.
   */
    public function timezoneDate($timestamp) 
    {
        if (!empty($timestamp)) {
            return $this->getTimeZoneAdjustedDateTime($timestamp, new DateTimeZone('America/New_York'));
        }
    }

  /**
   * Correctly offsets time into given timezone
   */
  public function getTimeZoneAdjustedDateTime($timestamp, $timezone) {
    if (!empty($timestamp)) {
      if (is_numeric($timestamp)) {
        $timestamp = date('Y-m-d H:i:s', $timestamp);
      }
    }
    if (is_array($timestamp) && isset($timestamp["#attributes"])) {
      $timestamp = $timestamp["#attributes"]["datetime"];
    }
    $utcTimezone = new DateTimeZone('UTC');
    $serverDateTime = new \DateTime($timestamp, $utcTimezone);
    $offset = $timezone->getOffset($serverDateTime);
    $myInterval=DateInterval::createFromDateString((string)$offset . 'seconds');
    $serverDateTime->add($myInterval);
    $result = $serverDateTime->format('Y-m-d H:i:s');
    
    return new \DateTime($result, $timezone);
    }

  /**
   * Returns a month based on AP Formatting.
   * When a month is used with a specific date, you may abbreviate "Jan." "Feb." "Aug." "Sept." "Oct." "Nov." and "Dec."
   * All remaining months may not be abbreviated.
   *
   * @param  Timestamp $date
   * @return string
   */
  private function _getAPMonth($date) {

         $month = $date->format("m");
         switch ($month) {
         case "01":
            case "02":
            case "08":
            case "10":
            case "11":
            case "12":
             return $date->format("M").".";
          break;
         case "09":
             return "Sept.";
          break;
         default:
             return $date->format("F");
          break;
         }
  }

  /**
  * Expose preg_replace in twig
  * @param String $subject - String to search and replace
  * @param String $pattern - Regex pattern to search for
  * @param String $replacement - String to replace
  * @param int $limit
  * @return string
  */
    public function regexReplace($subject, $pattern, $replacement='', $limit = -1) 
    {
        if (!isset($subject)) {
            return null;
        } else {
            return preg_replace($pattern, $replacement, $subject, $limit);
        }
    }

    /**
   * Provides function to programmatically rendering a menu
   *
   * @param String $menu_name
   *   The machine configuration id of the menu to render
   */
  public function renderMenu($menu_name) {
         $menu_tree = \Drupal::menuTree();

         // Build the typical default set of menu tree parameters.
         $parameters = $menu_tree->getCurrentRouteMenuTreeParameters($menu_name);

         // Load the tree based on this set of parameters.
         $tree = $menu_tree->load($menu_name, $parameters);

         // Transform the tree
         $manipulators = [
         // Only show links that are accessible for the current user.
         ['callable' => 'menu.default_tree_manipulators:checkAccess'],
         // Use the default sorting of menu links.
         ['callable' => 'menu.default_tree_manipulators:generateIndexAndSort'],
         ];
         $tree = $menu_tree->transform($tree, $manipulators);

         // Finally, build a renderable array from the transformed tree.
         $menu = $menu_tree->build($tree);

         return  ['#markup' =>  \Drupal::service('renderer')->render($menu)];
  }
}
