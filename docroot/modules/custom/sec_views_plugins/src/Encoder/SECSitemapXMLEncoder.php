<?php
namespace Drupal\sec_views_plugins\Encoder;

use Drupal\serialization\Encoder\XmlEncoder;
use Symfony\Component\HttpFoundation\Response;

class SECSitemapXMLEncoder extends XmlEncoder
{

    /**
   * {@inheritdoc}
   */
    static protected $format = ['sitemap_xml'];

    /**
   * Gets the base encoder instance.
   *
   * @return \Symfony\Component\Serializer\Encoder\XmlEncoder
   *   The base encoder.
   */
    public function getBaseEncoder() 
    {
        $base_encoder = parent::getBaseEncoder();
        $base_encoder->setRootNodeName('urlset');
        return $base_encoder;
    }


    /**
   * {@inheritdoc}
   */
    public function encode($data, $format, array $context = []) 
    {
        $context['views_style_plugin']->displayHandler->setMimeType('text/xml; charset=UTF-8');
        $newData = [];
        $location = [];

        foreach ($data as $index=>$dataList) {
            $location['loc'] = trim($dataList['loc'], '"');
            $newData['url'][]= $location;
        }
        $newFormat = $this->getBaseEncoder()->encode($newData, $format, $context);
        $newFormat = str_replace("version=\"1.0\"", "version=\"1.0\" encoding=\"UTF-8\"", $newFormat);
        $newFormat = str_replace("<urlset", "<urlset xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\"", $newFormat);

        return $newFormat;
    }


}
