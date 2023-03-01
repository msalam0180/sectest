<?php

function brokerage_account_statement_page_four() {
  $page_four = '<section data-index="4" class="brokerage_account_section inactive-right">
          <h2>' . t('Brokerage Account Statement') . '</h2>
          <p style="margin-bottom: 1rem; padding:0;"><span>Click this icon </span><span><svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="18px" height="18px" viewBox="0 0 24 24" enable-background="new 0 0 24 24" xml:space="preserve">
                        <path fill="none" d="M0,0h24v24H0V0z"></path>
                        <path d="M4,6H2v14c0,1.1,0.9,2,2,2h14v-2H4V6z M20,2H8C6.9,2,6,2.9,6,4v12c0,1.1,0.9,2,2,2h12c1.1,0,2-0.9,2-2V4C22,2.9,21.1,2,20,2z M19,11H9V9h10V11z M15,15H9v-2h6V15z M19,7H9V5h10V7z"></path>
                      </svg></span><span> to see additional info</span><p>
          <p><span class="statement-period">' . t('Statement Period') . '</span>
          ' . t('January 1 to January 31, 2015') . '</p>
          <div class="clickable-container">
            <h3><a href="javascript:;" title="Click this icon to see additional info" class="clickable midRight">' . t('Transaction Details ') . '<span>' . t('(for holdings with activity this period)') . '</span>
              <span><svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="24px" height="24px" viewBox="0 0 24 24" enable-background="new 0 0 24 24" xml:space="preserve">
                <path fill="none" d="M0,0h24v24H0V0z"/>
                <path d="M4,6H2v14c0,1.1,0.9,2,2,2h14v-2H4V6z M20,2H8C6.9,2,6,2.9,6,4v12c0,1.1,0.9,2,2,2h12c1.1,0,2-0.9,2-2V4C22,2.9,21.1,2,20,2z M19,11H9V9h10V11z M15,15H9v-2h6V15z M19,7H9V5h10V7z"/>
              </svg></span>
            </a></h3>
            <article class="info element-invisible">
              <h2 class="info-h2">' . t('Transaction Details (or Activity Details)') . '</h2>
              <p>' . t('This section provides detailed information about account activity during the relevant period and may include:') . '</p>
              <ul>
                <li>' . t('The date and price of each purchase or sale transaction') . '</li>
                <li>' . t('The date and amount of each deposit or withdrawal') . '</li>
                <li>' . t('The date and amount of dividends and interest received from your investments') . '</li>
                <li>' . t('The date and amount of dividends and interest reinvested') . '</li>
                <li>' . t('Realized capital gains or losses from sales in the account (gains or losses are “realized” when an asset is sold)') . '</li>
                <li>' . t('Transaction costs, such as sales loads, fees, or commissions') . '</li>
              </ul>
              <p class="alert">' . t('Compare the information in your account statement with your trade confirmations, especially if your financial professional can make trades on your behalf.') . '</p>
            </article>

            <h4>' . t('Brokerage Activity') . '</h4>

          <div class="brokerage_info-container">
            <div class="t_row">
              <div class="t_cell">' . t('Settlement Date') . '</div>
              <div class="t_cell">' . t('Security') . '</div>
              <div class="t_cell">' . t('Description') . '</div>
              <div class="t_cell">' . t('Quantity') . '</div>
              <div class="t_cell">' . t('Price per Unit') . '</div>
              <div class="t_cell" style="width: 115px;">
                <a href="javascript:;" title="Click this icon to see additional info" class="clickable midRight">' . t('Cost Basis') . '
                  <span><svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="18px" height="18px" viewBox="0 0 24 24" enable-background="new 0 0 24 24" xml:space="preserve">
                    <path fill="none" d="M0,0h24v24H0V0z"/>
                    <path d="M4,6H2v14c0,1.1,0.9,2,2,2h14v-2H4V6z M20,2H8C6.9,2,6,2.9,6,4v12c0,1.1,0.9,2,2,2h12c1.1,0,2-0.9,2-2V4C22,2.9,21.1,2,20,2z M19,11H9V9h10V11z M15,15H9v-2h6V15z M19,7H9V5h10V7z"/>
                  </svg></span>
                </a>
                <article class="info element-invisible">
                  <h2 class="info-h2">' . t('Cost Basis') . '</h2>
                  <p>' . t('<strong>Cost Basis: </strong>The original amount paid for a security, including the amount of reinvested dividends and capital gains, plus or minus certain adjustments. Not all basis adjustments may be reflected. The security cost basis can be used to estimate the capital gain or loss when you sell. This information is important for tax reporting and tax planning purposes.  You should consult your tax advisor about tax implications.') . '</p>
                </article>
              </div>
              <div class="t_cell">' . t('Transaction Amount') . '</div>
            </div>
            <div class="t_row">
              <div class="t_cell">' . t('1/1') . '</div>
              <div class="t_cell"></div>
              <div class="t_cell">' . t('Interest received') . '</div>
              <div class="t_cell"></div>
              <div class="t_cell"></div>
              <div class="t_cell"></div>
              <div class="t_cell">' . t('$10.00') . '</div>
            </div>
            <div class="t_row">
              <div class="t_cell">' . t('1/10') . '</div>
              <div class="t_cell"></div>
              <div class="t_cell">' . t('Dividend received') . '</div>
              <div class="t_cell"></div>
              <div class="t_cell"></div>
              <div class="t_cell"></div>
              <div class="t_cell">' . t('$3,990') . '</div>
            </div>
            <div class="t_row">
              <div class="t_cell">' . t('1/31') . '</div>
              <div class="t_cell"></div>
              <div class="t_cell">' . t('You sold ABC Mutual Fund') . '<br />' . t('Transaction cost -$10.00') . '</div>
              <div class="t_cell">' . t('-1000.000') . '</div>
              <div class="t_cell">' . t('28.01') . '</div>
              <div class="t_cell">' . t('$25,000') . '</div>
              <div class="t_cell">' . t('$28,000.00') . '<br />' . t('(net amount minus $10 transaction cost)') . '</div>
            </div>
          </div>
          </div>
        </section>';

    return $page_four;
}
