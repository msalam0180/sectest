<?php

/**
 * @file
 * Contains \src\Plugin\Block\LitigationReleasesBlock.
 */

namespace Drupal\sec_custom_blocks\Plugin\Block;

use Drupal\Core\Block\BlockBase;

use GuzzleHttp\Client;

use Symfony\Component\DependencyInjection\SimpleXMLElement;

/**
 * Provides a Litigation Releases block.
 *
 * @Block(
 *   id = "litigation_releases_block",
 *   admin_label = @Translation("Litigation Releases"),
 * )
 */

class LitigationReleasesBlock extends BlockBase
{

    /**
     * {@inheritdoc}
     */
    public function build() {

      $markup = '<h2>Latest Federal Court Actions</h2><h3>Litigation Releases</h3><ul>';
      try {
        $client = new Client();
        $response = $client->request('GET', 'https://www.sec.gov/rss/litigation/litreleases.xml');
        $xml = simplexml_load_string($response->getBody()->getContents());
        // If above statement returns false, the XML is invalid
        if (!$xml) {
          throw new \Exception('Invalid XML returned.');
        }
        for ($i = 0; $i < 5; $i++) {
          $item = $xml->channel->item[$i];
          $pubDate = strtotime($item->pubDate);
          $markup .= '<li><a href="' . $item->link . '">' . $item->title . '</a><span>' . date('M j, Y', $pubDate) . '</span></li>';
        }
      }
      catch (\Exception $e) {
        error_log('Exception raised in litigation releases homepage block: ' . $e->getMessage());
      }

      $markup .= '</ul><div class="more-link"><a href="//www.sec.gov/litigation/litreleases.shtml">More Litigation Releases</a></div>';
      return [
          '#type' => 'markup',
          '#markup' => $markup,
          '#theme' => 'sec_custom_blocks',
        ];
    }
}

