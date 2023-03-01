<?php

/**
 * @file
 */

namespace Drupal\sec_brokerage_account_statement\Plugin\Block;

use Drupal\Core\Block\BlockBase;

/**
 * Creates a 'Brokerage Account Statement' Block
 * @Block(
 * id = "block_brokerageacctstmt",
 * admin_label = @Translation("Brokerage Account Statement block"),
 * )
 */
class BrokerageAccountStatementBlock extends BlockBase
{

  /**
   * {@inheritdoc}
   */
  public function build()
  {
    return array(
      '#type' => 'inline_template',
      '#template' => sec_brokerage_account_statement_content(),
      '#attached' => array(
        'library' => array('sec_brokerage_account_statement/sec_brokerage_account_statement'),
      ),
      '#context' => [],
    );
  }

}
