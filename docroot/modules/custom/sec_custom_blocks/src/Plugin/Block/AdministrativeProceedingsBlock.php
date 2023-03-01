<?php

/**
 * @file
 * Contains \src\Plugin\Block\AdministrativeProceedingsBlock.
 */

namespace Drupal\sec_custom_blocks\Plugin\Block;

use Drupal\Core\Block\BlockBase;

use GuzzleHttp\Client;

use Symfony\Component\DependencyInjection\SimpleXMLElement;

/**
 * Provides an Administrative Proceedings block.
 *
 * @Block(
 *   id = "administrative_proceedings_block",
 *   admin_label = @Translation("Adiministrative Proceedings"),
 * )
 */

class AdministrativeProceedingsBlock extends BlockBase
{

    /**
     * {@inheritdoc}
     */
    public function build() {

      $markup = '<h2>Latest Administrative Proceedings</h2><h3>Administrative Releases</h3><ul>';
      try {
        $client = new Client();
        $response = $client->request('GET', 'https://www.sec.gov/rss/litigation/admin.xml');
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
        error_log('Exception raised in administrative proceedings homepage block: ' . $e->getMessage());
      }

        $markup .= '</ul><div class="more-link"><a href="//www.sec.gov/litigation/admin.shtml">More Administrative Releases</a></div>';
        return [
          '#type' => 'markup',
          '#markup' => $markup,
          '#theme' => 'sec_custom_blocks',
        ];
    }

}
