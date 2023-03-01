<?php
/**
 * @file
 * Contains \Drupal\Tests\mailsystem\Unit\AdapterTest.
 */

namespace Drupal\Tests\sec_urls\Unit;
use Drupal\sec_twigextensions\Twig\SecExtension;
use Drupal\Tests\UnitTestCase;

/**
 * Test the adapter class from mailsystem which is used as the mail plugin.
 *
 * @coversDefaultClass Drupal\sec_twigextensions\Twig\SecExtension
 * @group              sec_twigextensions
 * @group              sec
 */
class SecExtensionTest extends UnitTestCase
{
    
    /**
     * The class we need to test.
     *
     * @var Drupal\sec_twigextensions\Twig\SecExtension
     */
    protected $secExtension;
    
    /**
     * {@inheritdoc}
     */
    protected function setUp() 
    {
        $this->secExtension = new SecExtension();
    }
    
    /**
     * @covers ::apTime
     */
    public function testApTime() 
    {
        $this->assertEquals($this->secExtension->apTime(1508269774), "2:49 am EDT", "SEC Extension apTime failed to convert timestamp");
    }
    
    /**
     * @covers ::apDate
     */
    public function testApDate() 
    {
        $apDateError = "SECExtension::apDate failed to convert timestamp to AP Date Format";
        $this->assertEquals($this->secExtension->apDate(1508269774), "Oct. 18, 2017", $apDateError);
        $this->assertEquals($this->secExtension->apDate(1499158800), "July 4, 2017", $apDateError);
        $this->assertNotEquals($this->secExtension->apDate(1499158800), "Jul. 4, 2017", $apDateError);
        $this->assertEquals($this->secExtension->apDate("01/01/2018 09:00:00"), "Jan. 1, 2018", $apDateError);
        //timezone test! next assertion does not specify time so it defaults to midnight UTC which is previous day Eastern!
        $this->assertEquals($this->secExtension->apDate("01/01/2018"), "Dec. 31, 2017", $apDateError);
    }
    
    /**
     * @covers ::apDateMonthYear
     */
    public function testApDateMonthYear() 
    {
        $apDateError = "SECExtension::apDateMonthYear failed to convert timestamp to AP Date Month Year Format";
        $this->assertEquals($this->secExtension->apDateMonthYear(1508269774), "Oct. 2017", $apDateError);
        $this->assertEquals($this->secExtension->apDateMonthYear(1499158800), "July 2017", $apDateError);
        $this->assertNotEquals($this->secExtension->apDateMonthYear(1499158800), "Jul. 2017", $apDateError);
        $this->assertEquals($this->secExtension->apDateMonthYear("01/01/2018 09:00:00"), "Jan. 2018", $apDateError);
        //timezone test! next assertion does not specify time so it defaults to midnight UTC which is previous day Eastern!
        $this->assertEquals($this->secExtension->apDateMonthYear("01/01/2018"), "Dec. 2017", $apDateError);
    }
}