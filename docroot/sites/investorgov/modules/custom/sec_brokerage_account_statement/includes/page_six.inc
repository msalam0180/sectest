<?php

function brokerage_account_statement_page_six() {
  $page_six = '<section data-index="6" class="brokerage_account_section inactive-right all-text">
          <h2>' . t('Disclosures') . '</h2>
          <p style="margin-bottom: 1rem; padding:0;"><span>Click this icon </span><span><svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="18px" height="18px" viewBox="0 0 24 24" enable-background="new 0 0 24 24" xml:space="preserve">
                        <path fill="none" d="M0,0h24v24H0V0z"></path>
                        <path d="M4,6H2v14c0,1.1,0.9,2,2,2h14v-2H4V6z M20,2H8C6.9,2,6,2.9,6,4v12c0,1.1,0.9,2,2,2h12c1.1,0,2-0.9,2-2V4C22,2.9,21.1,2,20,2z M19,11H9V9h10V11z M15,15H9v-2h6V15z M19,7H9V5h10V7z"></path>
                      </svg></span><span> to see additional info</span><p>
          <div class="col">
              <div class="clickable-container cf">
                <a href="javascript:;" title="Click this icon to see additional info" class="clickable topRight">
                  <span class="paragraph-icon"><svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="18px" height="18px" viewBox="0 0 24 24" enable-background="new 0 0 24 24" xml:space="preserve">
                    <path fill="none" d="M0,0h24v24H0V0z"/>
                    <path d="M4,6H2v14c0,1.1,0.9,2,2,2h14v-2H4V6z M20,2H8C6.9,2,6,2.9,6,4v12c0,1.1,0.9,2,2,2h12c1.1,0,2-0.9,2-2V4C22,2.9,21.1,2,20,2z M19,11H9V9h10V11z M15,15H9v-2h6V15z M19,7H9V5h10V7z"/>
                  </svg></span>
                  <p class="disclosure bullet-point"><span class="bas_callout">' . t('If you have a question about your account or require service, please call your broker at Acme Brokers LLC (“Acme Brokers”).') . '</span></p>
                  <p class="disclosure bullet-point"><span class="bas_callout">' . t('Investment objectives/Risk tolerances:') . '</span>' . t(' Please advise us promptly of any material change that might affect your investment objectives, risk tolerance or financial situation, or if you wish to impose or change any reasonable restrictions on the management of your account.') . '</p>
                </a>
                <article class="info element-invisible">
                  <h2 class="info-h2">' . t('Remember to Read the Fine Print') . '</h2>
                  <ul>
                    <li>' . t('DON’T BE SHY! Ask your financial professional to explain or provide more detail about any information in your account statement.') . '</li>
                    <li>' . t('Promptly let your financial professional know of changes in your investment objectives, risk tolerance, or financial situation.  It’s important!') . '</li>
                  </ul>
                </article>
              </div>

              <div class="clickable-container cf">
                <a href="javascript:;" title="Click this icon to see additional info" class="clickable topRight">
                  <span class="paragraph-icon"><svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="18px" height="18px" viewBox="0 0 24 24" enable-background="new 0 0 24 24" xml:space="preserve">
                    <path fill="none" d="M0,0h24v24H0V0z"/>
                    <path d="M4,6H2v14c0,1.1,0.9,2,2,2h14v-2H4V6z M20,2H8C6.9,2,6,2.9,6,4v12c0,1.1,0.9,2,2,2h12c1.1,0,2-0.9,2-2V4C22,2.9,21.1,2,20,2z M19,11H9V9h10V11z M15,15H9v-2h6V15z M19,7H9V5h10V7z"/>
                  </svg></span>
                  <p class="disclosure bullet-point"><span class="bas_callout">' . t('Errors or Discrepancies:') . '</span>' . t('  Please review your statement and report any inaccuracies or discrepancies promptly to your clearing broker and, if you have one, to your introducing broker. Your clearing broker’s and, if you have one, your introducing broker’s address and telephone number can be found on the first page of this statement. Additionally, any oral communications regarding inaccuracies or discrepancies should be reconfirmed in writing to your clearing broker and, if you have one, to your introducing broker to further protect your rights, including those under the Securities Investor Protection Act ("SIPA"). If you do not object to the accuracy of the information reported on this statement promptly, we will consider it conclusive. In other words, by failing to object promptly, you agree that you have ratified as accurate all of the transactions and activities reported in this statement.') . '</p>
                </a>
                <article class="info element-invisible">
                  <h2 class="info-h2">' . t('Remember to Read the Fine Print') . '</h2>
                  <ul>
                    <li>' . t('If you believe assets are missing from your account or that a trade or transaction was made in error, to further protect your interests, contact the introducing broker (if you have one) and clearing firm by phone <em>and in writing</em>.') . '</li>
                  <ul>
                </article>
              </div>
              <div class="clickable-container cf">
                <a href="javascript:;" title="Click this icon to see additional info" class="clickable topRight">
                  <span class="paragraph-icon"><svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="18px" height="18px" viewBox="0 0 24 24" enable-background="new 0 0 24 24" xml:space="preserve">
                    <path fill="none" d="M0,0h24v24H0V0z"/>
                    <path d="M4,6H2v14c0,1.1,0.9,2,2,2h14v-2H4V6z M20,2H8C6.9,2,6,2.9,6,4v12c0,1.1,0.9,2,2,2h12c1.1,0,2-0.9,2-2V4C22,2.9,21.1,2,20,2z M19,11H9V9h10V11z M15,15H9v-2h6V15z M19,7H9V5h10V7z"/>
                  </svg></span>
                  <p class="disclosure bullet-point"><span class="bas_callout">' . t('Account Protection:') . '</span>' . t(' Brokerage services are provided by Acme Brokers, which clears all transactions through its affiliate, Acme Clearing.  Acme Clearing carries all brokerage accounts.  Acme Brokers and Acme Clearing are members of the Securities Investor Protection Corporation ("SIPC"). SIPC protects the clients of its member firms against the loss of their securities in the event of the member’s insolvency and liquidation.  Each client is protected for up to $500,000 (including $250,000 for claims for cash).  Acme Clearing has arranged for additional protection for cash and covered securities to supplement its SIPC coverage.  Neither coverage protects against a decline in the market value of securities.  For more information, including the SIPC brochure, please see www.sipc.org or call (202) 371-8300.') . '</p>
                </a>
                <article class="info element-invisible">
                  <h2 class="info-h2">' . t('Remember to Read the Fine Print') . '</h2>
                  <ul>
                    <li>' . t('SIPC states that it does NOT protect against a decline in the market value of securities and does NOT protect individuals who are sold worthless stocks and other securities or who receive bad investment advice or inappropriate investment recommendations.') . '</li>
                    <li>' . t('For more information regarding what SIPC protects, please see ') . '<a href="http://www.sipc.org">' . t('www.sipc.org') . '</a>.</li>
                  </ul>
                </article>
              </div>

              <div class="clickable-container cf">
                  <p class="disclosure bullet-point"><span class="bas_callout">' . t('Information About Mutual Funds and Their Performance:') . '</span>' . t(' Before investing consider the fund’s or insurance product’s investment objectives, risks, charges and expenses. Contact Acme Brokerage or visit our website for a prospectus containing this information.  Read it carefully before investing. Performance data shown represents past performance, and is no guarantee of future results.') . '</p>
              </div>
              <div class="clickable-container cf">
                <div class="clearfix">
                <a href="javascript:;" title="Click this icon to see additional info" class="clickable bottomRight">
                  <span class="paragraph-icon"><svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="18px" height="18px" viewBox="0 0 24 24" enable-background="new 0 0 24 24" xml:space="preserve">
                    <path fill="none" d="M0,0h24v24H0V0z"/>
                    <path d="M4,6H2v14c0,1.1,0.9,2,2,2h14v-2H4V6z M20,2H8C6.9,2,6,2.9,6,4v12c0,1.1,0.9,2,2,2h12c1.1,0,2-0.9,2-2V4C22,2.9,21.1,2,20,2z M19,11H9V9h10V11z M15,15H9v-2h6V15z M19,7H9V5h10V7z"/>
                  </svg></span>
                  <p class="disclosure bullet-point">' . t('An investment in a money market fund is not insured or guaranteed by the Federal Deposit Insurance Corporation or any other government agency. Although a money market fund seeks to preserve the value of your investment at $1.00 per share, it is possible to lose money by investing in the fund.') . '</p>
                </a>
                </div>
                <article class="info element-invisible">
                  <h2 class="info-h2">' . t('Remember to Read the Fine Print') . '</h2>
                  <ul>
                    <li>' . t('Money market funds are NOT FDIC insured, may lose value, and are not bank guaranteed.') . '</li>
                    <li>' . t('Certificates of deposit (CDs) and other bank products at FDIC-insured banks, such as bank deposit sweep accounts, are eligible for FDIC insurance up to $250,000 per depositor, per institution, in accordance with FDIC rules.') . '</li>
                  </ul>
                </article>
              </div>
            </div>
          <div class="col">
              <p class="disclosure bullet-point">' . t('Each fund reserves the right to terminate or modify its exchange privilege.') . '</p>
              <p class="disclosure bullet-point">' . t('Foreign investments, especially those in emerging markets, may involve greater risks than U.S. investments.') . '</p>
              <div class="clickable-container cf">
                <a href="javascript:;" title="Click this icon to see additional info" class="clickable topLeft">
                  <span class="paragraph-icon"><svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="18px" height="18px" viewBox="0 0 24 24" enable-background="new 0 0 24 24" xml:space="preserve">
                    <path fill="none" d="M0,0h24v24H0V0z"/>
                    <path d="M4,6H2v14c0,1.1,0.9,2,2,2h14v-2H4V6z M20,2H8C6.9,2,6,2.9,6,4v12c0,1.1,0.9,2,2,2h12c1.1,0,2-0.9,2-2V4C22,2.9,21.1,2,20,2z M19,11H9V9h10V11z M15,15H9v-2h6V15z M19,7H9V5h10V7z"/>
                  </svg></span>
                  <p class="disclosure bullet-point">' . t('In addition to sales loads and 12b-1 fees described in the prospectus, Acme Brokers or Acme Clearing receives other compensation in connection with the purchase and/or the on-going maintenance of positions in certain mutual fund shares and other investment products in your brokerage account. This additional compensation may be paid by the mutual fund or other investment provider, its investment adviser or one of its affiliates. Additional information about the source(s) and amount(s) of compensation as well as other remuneration received by Acme Brokers or Acme Clearing will be furnished to you upon written request.') . '</p>
                </a>
                <article class="info element-invisible">
                  <h2 class="info-h2">' . t('Remember to Read the Fine Print') . '</h2>
                  <ul>
                    <li>' . t('A sales load is the amount that you pay when you buy (front-end load) or redeem (back-end load) shares of certain mutual funds. 12b-1 fees are fees paid out of fund assets to cover the costs of marketing and selling fund shares.') . '</li>
                  </ul>
                </article>
              </div>
              <p class="disclosure bullet-point cf"><span class="bas_callout">' . t('Changes in Portfolio Value and Account Summary:') . '</span>' . t('  Shows activity in your portfolio and in each of your accounts for the statement period. ') . '</p>
              <p class="disclosure bullet-point"><span class="bas_callout">' . t('Value by Account:') . '</span>' . t('  Shows the value of your account(s), for the current and previous statement periods, grouped by investment type.') . '</p>
              <p class="disclosure bullet-point"><span class="bas_callout">' . t('Income Summary:') . '</span>' . t('  Shows income by tax status for the statement and year-to-date periods. Except for interest earned on, or distributed by, tax-exempt securities, Acme Brokerage reports dividends and capital gains held in taxable accounts as taxable income.') . '</p>
              <p class="disclosure bullet-point"><span class="bas_callout">' . t('Cost Basis:') . '</span>' . t('  The original amount paid for a security, including the amount of reinvested dividends and capital gains, plus or minus certain adjustments. Not all basis adjustments may be reflected. Use the security cost basis to estimate the capital gain or loss when you sell.  We may adjust cost basis for events such as disallowed losses (wash sales) and the reclassification of a dividend as a result of capital.') . '</p>
              <p class="disclosure bullet-point"><span class="bas_callout">' . t('Bank Deposit Sweep:') . '</span>' . t(' Consists of monies held at one or more other Acme Brokers affiliated banks. These assets are not covered by SIPC, but are instead eligible for FDIC insurance of up to $250,000 per depositor, per institution, in accordance with FDIC rules. For additional information on the Bank Deposit Sweep for your account, please contact  your broker.') . '</p>
              <p class="disclosure bullet-point cf"><span class="bas_callout">' . t('Change in Investment Value:') . '</span>' . t(' The appreciation or depreciation of your holdings due to price changes, plus any distribution and income earned during the statement period, less any transaction costs, sales charges, or fees you may have paid. ') . '</p>
          </div>
        </section>';

    return $page_six;
}
