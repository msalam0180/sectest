<?php

function brokerage_account_statement_page_three() {
  $page_three = '<section data-index="3" class="brokerage_account_section inactive-right">
          <h2>' . t('Brokerage Account Statement') . '</h2>
          <p style="margin-bottom: 1rem; padding:0;"><span>Click this icon </span><span><svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="18px" height="18px" viewBox="0 0 24 24" enable-background="new 0 0 24 24" xml:space="preserve">
                        <path fill="none" d="M0,0h24v24H0V0z"></path>
                        <path d="M4,6H2v14c0,1.1,0.9,2,2,2h14v-2H4V6z M20,2H8C6.9,2,6,2.9,6,4v12c0,1.1,0.9,2,2,2h12c1.1,0,2-0.9,2-2V4C22,2.9,21.1,2,20,2z M19,11H9V9h10V11z M15,15H9v-2h6V15z M19,7H9V5h10V7z"></path>
                      </svg></span><span> to see additional info</span><p>
          <p><span class="statement-period">' . t('Statement Period') . '</span>
          ' . t('January 1 to January 31, 2015') . '</p>
          <div>
            <div class="brokerage_info-container col">
              <div class="clickable-container">
                <div class="t_row">
                  <div class="t_cell">
                    <a href="javascript:;" title="Click this icon to see additional info" class="clickable topRight">' . t('Change in Account Value') . '
                      <span><svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="18px" height="18px" viewBox="0 0 24 24" enable-background="new 0 0 24 24" xml:space="preserve">
                        <path fill="none" d="M0,0h24v24H0V0z"/>
                        <path d="M4,6H2v14c0,1.1,0.9,2,2,2h14v-2H4V6z M20,2H8C6.9,2,6,2.9,6,4v12c0,1.1,0.9,2,2,2h12c1.1,0,2-0.9,2-2V4C22,2.9,21.1,2,20,2z M19,11H9V9h10V11z M15,15H9v-2h6V15z M19,7H9V5h10V7z"/>
                      </svg></span>
                    </a>
                    <article class="info element-invisible">
                      <h2 class="info-h2">' . t('Change in Account Value') . '</h2>
                      <ul>
                        <li>' . t('This section summarizes changes in account value, including changes in the market value of holdings and a summary of other account activity during the statement period and for the year-to-date.') . '</li>
                        <li>' . t('Numbers shown in (parentheses) are deductions or “debits” from the account’s value. They may reflect fees and charges, a decline in your investment assets’ value, or the sale of investments. Numbers not in parentheses reflect increases in or “credits” to the account.') . '</li>
                      </ul>
                    </article>
                  </div>
                  <div class="t_cell">' . t('This Period') . '</div>
                  <div class="t_cell">' . t('Year to Date') . '</div>
                </div>
                <div class="t_row">
                  <div class="t_cell"><strong>' . t('Starting Value') . '</strong></div>
                  <div class="t_cell"><strong>' . t('$125,000') . '</strong></div>
                  <div class="t_cell"><strong>' . t('$125,000') . '</strong></div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Cash Value of Purchases &amp; Sales') . '</div>
                  <div class="t_cell">' . t('$28,000') . '</div>
                  <div class="t_cell">' . t('$28,000') . '</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Investments Purchased/Sold') . '</div>
                  <div class="t_cell">' . t('($28,000)') . '</div>
                  <div class="t_cell">' . t('($28,000)') . '</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Deposits &amp; Withdrawals') . '</div>
                  <div class="t_cell">' . t('($28,000)') . '</div>
                  <div class="t_cell">' . t('($28,000)') . '</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Dividends &amp; Interest') . '</div>
                  <div class="t_cell">' . t('$4,000') . '</div>
                  <div class="t_cell">' . t('$4,000') . '</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Fees &amp; Charges') . '</div>
                  <div class="t_cell">' . t('($10.00)') . '</div>
                  <div class="t_cell">' . t('($10.00)') . '</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Transfers') . '</div>
                  <div class="t_cell">' . t('0.00') . '</div>
                  <div class="t_cell">' . t('0.00') . '</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Income Reinvested') . '</div>
                  <div class="t_cell">' . t('0.00') . '</div>
                  <div class="t_cell">' . t('0.00') . '</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Change in Value of Investments') . '</div>
                  <div class="t_cell">' . t('($1,000)') . '</div>
                  <div class="t_cell">' . t('($1,000)') . '</div>
                </div>
                <div class="t_row">
                  <div class="t_cell"><strong>' . t('Ending Value on 01/31/2015') . '</strong></div>
                  <div class="t_cell"><strong>' . t('$100,000') . '</strong></div>
                  <div class="t_cell"><strong>' . t('$100,000') . '</strong></div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Total Change in Account Value ') . '<br /><span>' . t('(Totals include Deposits &amp; Withdrawals)') . '</span></div>
                  <div class="t_cell">' . t('($25,000)') . '</div>
                  <div class="t_cell">' . t('($25,000)') . '</div>
                </div>
              </div>
            </div>

            <div class="brokerage_info-container col">
              <div class="t_row">
                <div class="t_cell">' . t('Account Value ($) Over Last 12 Months [in Thousands]') . '</div>
              </div>
              <div class="t_row">
                <div class="t_cell">
                  <span>
                    <title id="barGraph">Account investment bar graph</title>
                    <svg aria-labelledby="barGraph" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 657.36 307.69"><defs><style>.bg-cls-1{fill:none;stroke:#000;stroke-miterlimit:10;}.bg-cls-2{font-size:15px;font-family:Helvetica, Helvetica;}.bg-cls-3{fill:#00325b;}.bg-cls-4{letter-spacing:-0.07em;}.bg-cls-5{letter-spacing:-0.07em;}.bg-cls-6{letter-spacing:0em;}.bg-bg-cls-7{letter-spacing:-0.02em;}</style></defs><title>Asset 4</title><g id="Layer_2" data-name="Layer 2"><g id="Layer_1-2" data-name="Layer 1"><line class="bg-cls-1" x1="35.17" y1="277.06" x2="657.36" y2="277.06"/><text class="bg-cls-2" transform="translate(16.68 285.29)">0</text><text class="bg-cls-2" transform="translate(8.34 238.46)">30</text><text class="bg-cls-2" transform="translate(8.34 191.63)">60</text><text class="bg-cls-2" transform="translate(8.34 144.79)">90</text><text class="bg-cls-2" transform="translate(0 97.96)">120</text><text class="bg-cls-2" transform="translate(0 51.12)">150</text><line class="bg-cls-1" x1="35.17" y1="277.06" x2="657.36" y2="277.06"/><line class="bg-cls-1" x1="35.17" y1="230.23" x2="657.36" y2="230.23"/><line class="bg-cls-1" x1="35.17" y1="183.39" x2="657.36" y2="183.39"/><line class="bg-cls-1" x1="35.17" y1="136.56" x2="657.36" y2="136.56"/><line class="bg-cls-1" x1="35.17" y1="89.73" x2="657.36" y2="89.73"/><line class="bg-cls-1" x1="35.17" y1="42.89" x2="657.36" y2="42.89"/><rect class="bg-cls-3" x="586.25" y="120.95" width="38.97" height="156.11"/><rect class="bg-cls-3" x="539.08" y="81.92" width="38.97" height="195.14"/><rect class="bg-cls-3" x="491.9" y="117.83" width="38.97" height="159.23"/><rect class="bg-cls-3" x="444.72" y="105.34" width="38.97" height="171.72"/><rect class="bg-cls-3" x="397.55" y="89.73" width="38.97" height="187.34"/><rect class="bg-cls-3" x="350.37" y="74.11" width="38.97" height="202.95"/><rect class="bg-cls-3" x="303.2" y="66.31" width="38.97" height="210.75"/><rect class="bg-cls-3" x="256.02" y="70.99" width="38.97" height="206.07"/><rect class="bg-cls-3" x="208.85" y="77.24" width="38.97" height="199.82"/><rect class="bg-cls-3" x="161.67" y="74.11" width="38.97" height="202.95"/><rect class="bg-cls-3" x="114.49" y="89.73" width="38.97" height="187.34"/><rect class="bg-cls-3" x="67.32" y="81.92" width="38.97" height="195.14"/><text class="bg-cls-2" transform="translate(591.14 300.48)">1/15</text><text class="bg-cls-2" transform="translate(539.79 300.48)">12/14</text><text class="bg-cls-2" transform="translate(493.17 300.48)"><tspan class="bg-cls-4">1</tspan><tspan x="7.24" y="0">1/14</tspan></text><text class="bg-cls-2" transform="translate(445.44 300.48)">10/14</text><text class="bg-cls-2" transform="translate(402.43 300.48)">9/14</text><text class="bg-cls-2" transform="translate(355.26 300.48)">8/14</text><text class="bg-cls-2" transform="translate(308.08 300.48)">7/14</text><text class="bg-cls-2" transform="translate(260.91 300.48)">6/14</text><text class="bg-cls-2" transform="translate(213.73 300.48)">5/14</text><text class="bg-cls-2" transform="translate(166.56 300.48)">4/14</text><text class="bg-cls-2" transform="translate(119.38 300.48)">3/14</text><text class="bg-cls-2" transform="translate(72.2 300.48)">2/14</text><text class="bg-cls-2" transform="translate(150.11 12.88)">Account <tspan class="bg-cls-5" x="58.37" y="0">V</tspan><tspan class="bg-cls-6" x="67.27" y="0">alue ($) Over Last 12 Months [in</tspan><tspan class="bg-cls-7" x="281.54" y="0"> </tspan><tspan x="285.44" y="0">Thousands]</tspan></text></g></g></svg>
                  </span>
                </div>
              </div>
            </div>
          </div>
          <div style="clear: both;">
            <div class="brokerage_info-container col">
              <div class="clickable-container">
                <div class="t_row">
                  <div class="t_cell">
                    <a href="javascript:;" title="Click this icon to see additional info" class="clickable topRight">' . t('Asset Allocation') . '
                      <span><svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="18px" height="18px" viewBox="0 0 24 24" enable-background="new 0 0 24 24" xml:space="preserve">
                        <path fill="none" d="M0,0h24v24H0V0z"/>
                        <path d="M4,6H2v14c0,1.1,0.9,2,2,2h14v-2H4V6z M20,2H8C6.9,2,6,2.9,6,4v12c0,1.1,0.9,2,2,2h12c1.1,0,2-0.9,2-2V4C22,2.9,21.1,2,20,2z M19,11H9V9h10V11z M15,15H9v-2h6V15z M19,7H9V5h10V7z"/>
                      </svg></span>
                    </a>
                    <article class="info element-invisible">
                      <h2 class="info-h2">' . t('Asset Allocation') . '</h2>
                      <ul>
                        <li>' . t('This section shows the account by investment type, providing the percentage held in cash, equities (stock), fixed income (bonds), mutual funds, and other types of securities. It may use a graph or pie chart so that you see at a glance what investments you hold, allowing you to easily review your asset allocation.') . '</li>
                      </ul>
                    </article>
                  </div>
                  <div class="t_cell" style="width: 130px;">
                    <a href="javascript:;" title="Click this icon to see additional info" class="clickable topRight">' . t('Market Value') . '
                      <span><svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="18px" height="18px" viewBox="0 0 24 24" enable-background="new 0 0 24 24" xml:space="preserve">
                        <path fill="none" d="M0,0h24v24H0V0z"/>
                        <path d="M4,6H2v14c0,1.1,0.9,2,2,2h14v-2H4V6z M20,2H8C6.9,2,6,2.9,6,4v12c0,1.1,0.9,2,2,2h12c1.1,0,2-0.9,2-2V4C22,2.9,21.1,2,20,2z M19,11H9V9h10V11z M15,15H9v-2h6V15z M19,7H9V5h10V7z"/>
                      </svg></span>
                    </a>
                    <article class="info element-invisible test">
                      <h2 class="info-h2">' . t('Market Value') . '</h2>
                      <ul>
                        <li>' . t('Market value is the amount you generally would receive if you were to sell an asset. It will likely fluctuate based on market conditions. For securities that trade frequently, the market value is based on prices for recent transactions. For securities that trade infrequently, the value may be an estimate based on market data that may not be current.') . '</li>
                      <ul>
                    </article>
                  </div>
                  <div class="t_cell">' . t('% of Account Assets') . '</div>
                </div>
                <div class="t_row clickable-container">
                  <div class="t_cell">
                    <a href="javascript:;" title="Click this icon to see additional info" class="clickable bottomRight">' . t('Money Market Funds [Sweep]') . '
                      <span><svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="18px" height="18px" viewBox="0 0 24 24" enable-background="new 0 0 24 24" xml:space="preserve">
                        <path fill="none" d="M0,0h24v24H0V0z"/>
                        <path d="M4,6H2v14c0,1.1,0.9,2,2,2h14v-2H4V6z M20,2H8C6.9,2,6,2.9,6,4v12c0,1.1,0.9,2,2,2h12c1.1,0,2-0.9,2-2V4C22,2.9,21.1,2,20,2z M19,11H9V9h10V11z M15,15H9v-2h6V15z M19,7H9V5h10V7z"/>
                      </svg></span>
                    </a>
                    <article class="info element-invisible">
                      <h2 class="info-h2">' . t('"Sweep" Accounts') . '</h2>
                      <ul>
                        <li>' . t('You may have agreed to a certain treatment of your excess cash when establishing your account, perhaps without being aware of that agreement. Understand how excess cash is treated and ask the broker for a full explanation if necessary. Your financial professional should explain the options available. If your broker offers you choices, it must agree to the option you select—even if your choice isn’t the brokerage’s “default”.') . '</li>
                        <li>' . t('One option your broker may offer to manage excess cash is a bank sweep program, which typically involves the automatic transfer or “sweep” of cash in the brokerage account to a bank that holds the cash for you. The bank may or may not be affiliated with your broker. Other options may include keeping cash in the brokerage account or sweeping cash into one or more money market mutual funds.') . '</li>
                        <li>' . t('Regularly check the “cash and cash equivalents” line to confirm that the broker is following your instructions on treatment of excess cash. If your cash balance is larger or smaller than you expect or want, call your financial professional to discuss your options.') . '</li>
                      </ul>
                    </article>
                  </div>
                  <div class="t_cell">' . t('$30,000') . '</div>
                  <div class="t_cell">' . t('30%') . '</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Equities') . '</div>
                  <div class="t_cell">' . t('$5,000') . '</div>
                  <div class="t_cell">' . t('5%') . '</div>
                </div>
                 <div class="t_row">
                  <div class="t_cell">' . t('Mutual Funds') . '</div>
                  <div class="t_cell">' . t('$25,000') . '</div>
                  <div class="t_cell">' . t('25%') . '</div>
                </div>
                 <div class="t_row">
                  <div class="t_cell">' . t('Fixed Income') . '</div>
                  <div class="t_cell">' . t('$15,000') . '</div>
                  <div class="t_cell">' . t('15%') . '</div>
                </div>
                 <div class="t_row">
                  <div class="t_cell">' . t('Investments Held Outside') . '</div>
                  <div class="t_cell">' . t('$25,000') . '</div>
                  <div class="t_cell">' . t('25%') . '</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Total Assets') . '</div>
                  <div class="t_cell">' . t('$100,000') . '</div>
                  <div class="t_cell">' . t('100%') . '</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Total Account Value') . '</div>
                  <div class="t_cell">' . t('$100,000') . '</div>
                  <div class="t_cell">' . t('100%') . '</div>
                </div>
              </div>
            </div>
              <div class="brokerage_info-container col">
                <div class="t_row">
                  <div class="t_cell">' . t('Overview') . '</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">
                    <span>
                      <title id="pieChart2">Account investment summary pie chart</title>
                      <svg aria-labelledby="pieChart2" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 524.44 408.3"><defs><style>.pc2-cls-1{fill:#00325b;}.pc2-cls-1,.pc2-cls-2,.pc2-cls-3,.pc2-cls-4,.pc2-cls-5{stroke:#231f20;}.pc2-cls-1,.pc2-cls-2,.pc2-cls-3,.pc2-cls-4,.pc2-cls-5,.pc2-cls-7{stroke-miterlimit:10;}.pc2-cls-2{fill:#269092;}.pc2-cls-3{fill:#73808b;}.pc2-cls-4{fill:#bf280d;}.pc2-cls-5{fill:#eee;}.pc2-cls-6{font-size:16px;font-family:Helvetica, Helvetica;}.pc2-cls-7{fill:none;stroke:#000;}</style></defs><title>Asset 6</title><g id="Layer_2" data-name="Layer 2"><g id="Layer_1-2" data-name="Layer 1"><path class="pc2-cls-1" d="M273.15,196.59,130.38,92.86c34.37-47.31,84.29-72.74,142.77-72.74Z"/><path class="pc2-cls-2" d="M273.15,196.59,169.42,339.36a176.47,176.47,0,0,1-39-246.5h0Z"/><path class="pc2-cls-3" d="M273.15,196.59,417.7,297.81a176.47,176.47,0,0,1-245.78,43.34l-2.51-1.79Z"/><path class="pc2-cls-4" d="M273.15,196.59,441,251.12c-6,18.54-12.1,30.72-23.28,46.69Z"/><path class="pc2-cls-5" d="M273.15,196.59V20.12A176.47,176.47,0,0,1,449.62,196.59,167.76,167.76,0,0,1,441,251.12Z"/><text class="pc2-cls-6" transform="translate(318.78 400.61)">Mutual Funds</text><text class="pc2-cls-6" transform="translate(410.09 54)">Money Market <tspan x="30.67" y="19.2">Funds</tspan></text><text class="pc2-cls-6" transform="translate(467.52 297.81)">Equities</text><text class="pc2-cls-6" transform="translate(82.36 13.74)">Fixed Income</text><text class="pc2-cls-6"><tspan x="3.12" y="275.18">Investments</tspan><tspan x="0" y="294.38">Held Outside</tspan></text><line class="pc2-cls-7" x1="184.9" y1="43" x2="174.08" y2="20.12"/><line class="pc2-cls-7" x1="410.58" y1="85.9" x2="431.08" y2="65.13"/><line class="pc2-cls-7" x1="430.62" y1="276.71" x2="457.08" y2="290.46"/><line class="pc2-cls-7" x1="298.06" y1="371.28" x2="311.08" y2="395.46"/><line class="pc2-cls-7" x1="104.09" y1="247.2" x2="76.08" y2="254.81"/></g></g></svg>
                    </span>
                  </div>
                </div>
              </div>
            </div>
        </section>';

    return $page_three;
}
