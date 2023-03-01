<?php

function brokerage_account_statement_page_two() {
  $page_two = '<section data-index="2" class="brokerage_account_section inactive-right">
          <h2>' . t('Brokerage Account Statement') . '</h2>
          <p style="margin-bottom: 1rem; padding:0;"><span>Click this icon </span><span><svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="18px" height="18px" viewBox="0 0 24 24" enable-background="new 0 0 24 24" xml:space="preserve">
                        <path fill="none" d="M0,0h24v24H0V0z"></path>
                        <path d="M4,6H2v14c0,1.1,0.9,2,2,2h14v-2H4V6z M20,2H8C6.9,2,6,2.9,6,4v12c0,1.1,0.9,2,2,2h12c1.1,0,2-0.9,2-2V4C22,2.9,21.1,2,20,2z M19,11H9V9h10V11z M15,15H9v-2h6V15z M19,7H9V5h10V7z"></path>
                      </svg></span><span> to see additional info</span><p>
          <p><span class="statement-period">' . t('Statement Period') . '</span>
          ' . t('January 1 to January 31, 2015') . '</p>
          <div>
            <div class="col">
              <div class="clickable-container">
                <h3><a href="javascript:;" title="Click this icon to see additional info" class="clickable topRight">' . t('Account Investment Summary ') . '<span>' . t('as of January 31, 2015') . '</span>
                <span><svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="24px" height="24px" viewBox="0 0 24 24" enable-background="new 0 0 24 24" xml:space="preserve">
                  <path fill="none" d="M0,0h24v24H0V0z"/>
                  <path d="M4,6H2v14c0,1.1,0.9,2,2,2h14v-2H4V6z M20,2H8C6.9,2,6,2.9,6,4v12c0,1.1,0.9,2,2,2h12c1.1,0,2-0.9,2-2V4C22,2.9,21.1,2,20,2z M19,11H9V9h10V11z M15,15H9v-2h6V15z M19,7H9V5h10V7z"/>
                </svg></span>
              </a></h3>
              <article class="info element-invisible">
                <h2 class="info-h2">' . t('Account Summary: Your account at a glance') . '</h2>
                <ul>
                  <li>' . t('This section provides an overview of the account’s total value.  It may be broken down by investments in the account, such as cash, equities (stock), fixed income (bonds), mutual funds, exchange traded funds or ETFs, and other holdings.') . '</li>
                  <li>' . t('Some investments may be held on your behalf by a company other than your clearing broker, such as a bank.') . '</li>
                </ul>
                <p class="alert">' . t('Compare the information in your account statement with your trade confirmations, especially if your financial professional can make trades on your behalf.') . '</p>
              </article>
                <div class="brokerage_info-container">
                  <div class="t_row">
                    <div class="t_cell">' . t('Investment Type') . '</div>
                    <div class="t_cell">' . t('Amount') . '</div>
                    <div class="t_cell">' . t('Percent') . '</div>
                  </div>
                  <div class="t_row clickable-container">
                    <div class="t_cell"><a href="javascript:;" title="Click this icon to see additional info" class="clickable topRight">' . t('Cash and Cash Equivalents') . '
                      <span><svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="18px" height="18px" viewBox="0 0 24 24" enable-background="new 0 0 24 24" xml:space="preserve">
                        <path fill="none" d="M0,0h24v24H0V0z"/>
                        <path d="M4,6H2v14c0,1.1,0.9,2,2,2h14v-2H4V6z M20,2H8C6.9,2,6,2.9,6,4v12c0,1.1,0.9,2,2,2h12c1.1,0,2-0.9,2-2V4C22,2.9,21.1,2,20,2z M19,11H9V9h10V11z M15,15H9v-2h6V15z M19,7H9V5h10V7z"/>
                      </svg></span>
                    </a>
                    <article class="info element-invisible">
                      <h2 class="info-h2">' . t('Cash and Cash Equivalent') . '</h2>
                      <ul>
                        <li>' . t('Cash and cash equivalents refer to cash or holdings that can be converted into cash almost immediately, including money market funds and other short-term, highly liquid investments with a maturity of three months or less, such as U.S. Treasury bills.') . '</li>
                      </ul>
                    </article>
                    </div>
                    <div class="t_cell">' . t('$30,000') . '</div>
                    <div class="t_cell">' . t('30%') . '</div>
                  </div>
                  <div class="t_row">
                    <div class="t_cell">' . t('Equities and Options') . '</div>
                    <div class="t_cell">' . t('$5,000') . '</div>
                    <div class="t_cell">' . t('5%') . '</div>
                  </div>
                  <div class="t_row">
                    <div class="t_cell">' . t('Fixed Income') . '</div>
                    <div class="t_cell">' . t('$15,000') . '</div>
                    <div class="t_cell">' . t('15%') . '</div>
                  </div>
                  <div class="t_row">
                    <div class="t_cell">' . t('Mutual Funds') . '</div>
                    <div class="t_cell">' . t('$25,000') . '</div>
                    <div class="t_cell">' . t('25%') . '</div>
                  </div>
                  <div class="t_row clickable-container">
                    <div class="t_cell">' . t('Investments Held Outside ') . '</div>
                    <div class="t_cell">' . t('$25,000') . '</div>
                    <div class="t_cell">' . t('25%') . '</div>
                  </div>
                  <div class="t_row">
                    <div class="t_cell">' . t('Total') . '</div>
                    <div class="t_cell">' . t('$100,000') . '</div>
                    <div class="t_cell">' . t('100%') . '</div>
                  </div>
                </div>
              </div>
            </div>
            <div class="col">
              <span>
                <title id="pieChart1">Account investment summary pie chart</title>
                <svg xmlns="http://www.w3.org/2000/svg" width="85%" height="85%" viewBox="0 0 550.59 421.54"><defs><style>.cls-1{fill:#bf280d;}.cls-1,.cls-2,.cls-3,.cls-4,.cls-5{stroke:#231f20;stroke-miterlimit:10;}.cls-2{fill:#00325b;}.cls-3{fill:#269092;}.cls-4{fill:#73808b;}.cls-5{fill:#eee;}.cls-6,.cls-7{isolation:isolate;}.cls-6{font-size:16px;font-family:Helvetica, Helvetica;}.cls-8{fill:none;stroke:#000;}</style></defs><title>Asset 1</title><g id="Layer_2" data-name="Layer 2"><g id="Layer_1-2" data-name="Layer 1"><g id="Layer_2-2" data-name="Layer 2"><g id="Layer_1-2-2" data-name="Layer 1-2"><path class="cls-1" d="M266.16,237.33,211.63,69.49a167.76,167.76,0,0,1,54.53-8.64Z"/><path class="cls-2" d="M266.16,237.33,98.32,182.79C116.4,127.18,156,87.56,211.63,69.49Z"/><path class="cls-3" d="M266.16,237.33,211.63,405.16A176.47,176.47,0,0,1,98.32,182.8h0Z"/><path class="cls-4" d="M266.16,237.33,434,291.86a176.47,176.47,0,0,1-222.36,113.3h0Z"/><path class="cls-5" d="M266.16,237.33V60.85A176.47,176.47,0,0,1,442.63,237.32h0A167.76,167.76,0,0,1,434,291.86Z"/><text class="cls-6" transform="translate(379.78 413.85)">Mutual Funds</text><g class="cls-7"><text class="cls-6" transform="translate(435.86 99.72)">Cash and Cash </text><text class="cls-6" transform="translate(445.63 118.92)">Equivalents</text></g><g class="cls-7"><text class="cls-6" transform="translate(173.79 13.74)">Equities</text><text class="cls-6" transform="translate(159.11 32.94)">and Options</text></g><text class="cls-6" transform="translate(28.3 75.73)">Fixed Income</text><text class="cls-6" transform="translate(0 353.9)">Held Outside</text><line class="cls-8" x1="238.89" y1="62.86" x2="234.25" y2="38.42"/><line class="cls-8" x1="411.54" y1="137.28" x2="434" y2="115.21"/><line class="cls-8" x1="357.73" y1="388.18" x2="374.25" y2="419.01"/><line class="cls-8" x1="108.42" y1="316.43" x2="79.25" y2="334.01"/><line class="cls-8" x1="140.6" y1="112.36" x2="129.25" y2="82.37"/></g></g></g></g></svg>
              </span>
            </div>
          </div>
          <div class="clickable-container col cf">
            <h3><a href="javascript:;" title="Click this icon to see additional info" class="clickable bottomRight">' . t('Investments Held Outside ACME Brokers') . '
              <span><svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="24px" height="24px" viewBox="0 0 24 24" enable-background="new 0 0 24 24" xml:space="preserve">
                <path fill="none" d="M0,0h24v24H0V0z"/>
                <path d="M4,6H2v14c0,1.1,0.9,2,2,2h14v-2H4V6z M20,2H8C6.9,2,6,2.9,6,4v12c0,1.1,0.9,2,2,2h12c1.1,0,2-0.9,2-2V4C22,2.9,21.1,2,20,2z M19,11H9V9h10V11z M15,15H9v-2h6V15z M19,7H9V5h10V7z"/>
              </svg></span>
            </a></h3>
            <article class="info element-invisible">
              <h2 class="info-h2">' . t('Investments Held Outside ACME Brokers') . '</h2>
              <h3>' . t('Carefully Review Consolidated Financial Account Reports') . '</h3>
              <ul>
                <li>' . t('Some brokers provide clients with consolidated financial account reports that include information about assets that are “held outside” or “away from” your financial professional’s firm, for instance in other investment, retirement, or cash sweep banking accounts.') . '</li>
              </ul>
              <h3>' . t('Consolidated reports do not replace account statements received from the financial institution(s) that hold your other assets. Read, compare, and understand all of your account statements.') . '</h3>
              <ul>
                <li>' . t('Remember that your broker has not verified or confirmed all of the data presented and that you should continue reviewing your other account statements.') . '</li>
              </ul>
            </article>
            <div class="brokerage_info-container">
              <div class="t_row">
                <div class="t_cell">&nbsp;</div>
                <div class="t_cell">&nbsp;</div>
                <div class="t_cell"><span class="statement-period">' . t('Value on') . '</span>' . t(' January 1, 2015') . '</div>
                <div class="t_cell"><span class="statement-period">' . t('Value on') . '</span>' . t(' January 31, 2015') . '</div>
              </div>
              <div class="t_row">
                <div class="t_cell">' . t('Investments Held Outside') . '</div>
                <div class="t_cell">&nbsp;</div>
                <div class="t_cell">' . t('$25,000') . '</div>
                <div class="t_cell">' . t('$25,000') . '</div>
              </div>
              <div class="t_row">
                <div class="t_cell"><strong>' . t('Total Account Value Including Investments Held Outside') . '</strong></div>
                <div class="t_cell">&nbsp;</div>
                <div class="t_cell"><strong>' . t('$125,000') . '</strong></div>
                <div class="t_cell"><strong>' . t('$100,000') . '</strong></div>
              </div>
            </div>
          </div>
          <div>
            <div class="brokerage_info-container col clickable-container">
              <h3>' . t('Earnings Summary') . '</h3><span>' . t('as of January 31, 2015') . '</span>
              <div class="t_row">
                <div class="t_cell"><a href="javascript:;" title="Click this icon to see additional info" class="clickable topLeft">' . t('Estimated Annual Income') . '
                  <span><svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="18px" height="18px" viewBox="0 0 24 24" enable-background="new 0 0 24 24" xml:space="preserve">
                    <path fill="none" d="M0,0h24v24H0V0z"/>
                    <path d="M4,6H2v14c0,1.1,0.9,2,2,2h14v-2H4V6z M20,2H8C6.9,2,6,2.9,6,4v12c0,1.1,0.9,2,2,2h12c1.1,0,2-0.9,2-2V4C22,2.9,21.1,2,20,2z M19,11H9V9h10V11z M15,15H9v-2h6V15z M19,7H9V5h10V7z"/>
                  </svg></span>
                </a>
                <article class="info element-invisible">
                  <h2 class="info-h2">' . t('Estimated Annual Income') . '</h2>
                  <ul>
                    <li>' . t('Brokerage statements may provide estimates of income, dividend, and yield information for specific securities in an account. Actual income and yield may be higher or lower.') . '</li>
                  </ul>
                </article>
                </div>
                <div class="t_cell">' . t('$7,500') . '</div>
              </div>
            </div>
            <div class="brokerage_info-container col">
              <h3>' . t('Purchasing Power') . '</h3><span>' . t('as of January 31, 2015') . '</span>
              <div class="t_row">
                <div class="t_cell">' . t('Available Cash') . '</div>
                <div class="t_cell">' . t('$30,000') . '</div>
              </div>
            </div>
          </div>
        </section>';

    return $page_two;
}
