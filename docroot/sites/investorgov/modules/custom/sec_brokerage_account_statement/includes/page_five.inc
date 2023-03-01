<?php

function brokerage_account_statement_page_five() {
  $page_five = '<section data-index="5" class="brokerage_account_section inactive-right">
          <h2>' . t('Brokerage Account Statement') . '</h2>
          <p style="margin-bottom: 1rem; padding:0;"><span>Click this icon </span><span><svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="18px" height="18px" viewBox="0 0 24 24" enable-background="new 0 0 24 24" xml:space="preserve">
                        <path fill="none" d="M0,0h24v24H0V0z"></path>
                        <path d="M4,6H2v14c0,1.1,0.9,2,2,2h14v-2H4V6z M20,2H8C6.9,2,6,2.9,6,4v12c0,1.1,0.9,2,2,2h12c1.1,0,2-0.9,2-2V4C22,2.9,21.1,2,20,2z M19,11H9V9h10V11z M15,15H9v-2h6V15z M19,7H9V5h10V7z"></path>
                      </svg></span><span> to see additional info</span><p>
          <p><span class="statement-period">' . t('Statement Period') . '</span>
          ' . t('January 1 to January 31, 2015') . '</p>
          <div class="col">
            <div class="clickable-container">
              <h3><a href="javascript:;" title="Click this icon to see additional info" class="clickable topRight">' . t('Activity Summary') . '
                <span><svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="24px" height="24px" viewBox="0 0 24 24" enable-background="new 0 0 24 24" xml:space="preserve">
                  <path fill="none" d="M0,0h24v24H0V0z"/>
                  <path d="M4,6H2v14c0,1.1,0.9,2,2,2h14v-2H4V6z M20,2H8C6.9,2,6,2.9,6,4v12c0,1.1,0.9,2,2,2h12c1.1,0,2-0.9,2-2V4C22,2.9,21.1,2,20,2z M19,11H9V9h10V11z M15,15H9v-2h6V15z M19,7H9V5h10V7z"/>
                </svg></span>
              </a></h3>
              <article class="info element-invisible">
                <h2 class="info-h2">' . t('Activity Summary') . '</h2>
                <ul>
                  <li>' . t('This section summarizes the activity or "cash flow" in the account during the statement period and year-to-date – essentially what went in and out of the account(s), shown in the “Transaction Details” sections, such as:') . '
                    <ul>
                      <li>' . t('securities purchased and securities sold or "redeemed"') . '</li>
                      <li>' . t('deposits into and withdrawals or deductions from your account') . '</li>
                      <li>' . t('income and distributions from your investments, such as dividends, interest, and capital gains') . '</li>
                      <li>' . t('fees, commissions, and other charges') . '</li>
                      <li>' . t('income that is reinvested in the securities') . '</li>
                      <li>' . t('changes in the value of the investments') . '</li>
                    </ul>
                  </li>
                  </ul>
                </article>
              <div class="brokerage_info-container">
                <div class="t_row">
                  <div class="t_cell">&nbsp;</div>
                  <div class="t_cell">' . t('on January 31, 2015 ($)') . '</div>
                  <div class="t_cell">' . t('Year to date ($)') . '</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Additions') . '</div>
                  <div class="t_cell">&nbsp;</div>
                  <div class="t_cell">&nbsp;</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Deposits, security transfers received') . '</div>
                  <div class="t_cell">&ndash;</div>
                  <div class="t_cell">&ndash;</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Income received') . '</div>
                  <div class="t_cell">' . t('$4,000') . '</div>
                  <div class="t_cell">' . t('$4,000') . '</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Other funds credited') . '</div>
                  <div class="t_cell">&ndash;</div>
                  <div class="t_cell">&ndash;</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Proceeds from security transactions') . '</div>
                  <div class="t_cell">' . t('$28,000') . '</div>
                  <div class="t_cell">' . t('$28,000') . '</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Total additions') . '</div>
                  <div class="t_cell">' . t('$4,000') . '</div>
                  <div class="t_cell">' . t('$4,000') . '</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Subtractions') . '</div>
                  <div class="t_cell">&nbsp;</div>
                  <div class="t_cell">&nbsp;</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Checks and bill payments') . '</div>
                  <div class="t_cell">&ndash;</div>
                  <div class="t_cell">&ndash;</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Interest charges') . '</div>
                  <div class="t_cell">&ndash;</div>
                  <div class="t_cell">&ndash;</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Withdrawals, security transfers delivered') . '</div>
                  <div class="t_cell">' . t('($28,000)') . '</div>
                  <div class="t_cell">' . t('($28,000)') . '</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Foreign and/or federal tax withheld') . '</div>
                  <div class="t_cell">&ndash;</div>
                  <div class="t_cell">&ndash;</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Funds withdrawn for securities transactions') . '</div>
                  <div class="t_cell">&ndash;</div>
                  <div class="t_cell">&ndash;</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Fees/Expenses') . '</div>
                  <div class="t_cell">' . t('($10)') . '</div>
                  <div class="t_cell">' . t('($10)') . '</div>
                </div>
              </div>
            </div>
            <div class="clickable-container">
              <h3><a href="javascript:;" title="Click this icon to see additional info" class="clickable topRight">
                ' . t('Income Summary') . '
                <span><svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="24px" height="24px" viewBox="0 0 24 24" enable-background="new 0 0 24 24" xml:space="preserve">
                  <path fill="none" d="M0,0h24v24H0V0z"/>
                  <path d="M4,6H2v14c0,1.1,0.9,2,2,2h14v-2H4V6z M20,2H8C6.9,2,6,2.9,6,4v12c0,1.1,0.9,2,2,2h12c1.1,0,2-0.9,2-2V4C22,2.9,21.1,2,20,2z M19,11H9V9h10V11z M15,15H9v-2h6V15z M19,7H9V5h10V7z"/>
                </svg></span>
              </a></h3>
              <article class="info element-invisible">
                <h2 class="info-h2">' . t('Income Summary') . '</h2>
                <ul>
                  <li>' . t('This section shows the income the account earned for the statement period and year-to-date from dividends, capital gains, or interest. This information is important for tax reporting and tax planning purposes. You should consult your tax advisor about tax implications.') . '</li>
                </ul>
              </article>
              <div class="brokerage_info-container">
                <div class="t_row">
                  <div class="t_cell">&nbsp;</div>
                  <div class="t_cell">' . t('on January 31, 2015 ($)') . '</div>
                  <div class="t_cell">' . t('Year to date, 2015 ($)') . '</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Taxable dividends') . '</div>
                  <div class="t_cell">' . t('$3,990') . '</div>
                  <div class="t_cell">' . t('$3,990') . '</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Non-taxable dividends') . '</div>
                  <div class="t_cell">&ndash;</div>
                  <div class="t_cell">&ndash;</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Taxable interest') . '</div>
                  <div class="t_cell">' . t('$10.00') . '</div>
                  <div class="t_cell">' . t('$10.00') . '</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Non-taxable interest') . '</div>
                  <div class="t_cell">&ndash;</div>
                  <div class="t_cell">&ndash;</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Capital gain income') . '</div>
                  <div class="t_cell">&ndash;</div>
                  <div class="t_cell">&ndash;</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Limited partnership distributions') . '</div>
                  <div class="t_cell">&ndash;</div>
                  <div class="t_cell">&ndash;</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Other taxable income') . '</div>
                  <div class="t_cell">&ndash;</div>
                  <div class="t_cell">&ndash;</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Other non-taxable income') . '</div>
                  <div class="t_cell">&ndash;</div>
                  <div class="t_cell">&ndash;</div>
                </div>
              </div>
            </div>
            <div class="clickable-container">
              <h3><a href="javascript:;" title="Click this icon to see additional info" class="clickable bottomRight">
                ' . t('Gain/Loss Summary') . '
                <span><svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="24px" height="24px" viewBox="0 0 24 24" enable-background="new 0 0 24 24" xml:space="preserve">
                  <path fill="none" d="M0,0h24v24H0V0z"/>
                  <path d="M4,6H2v14c0,1.1,0.9,2,2,2h14v-2H4V6z M20,2H8C6.9,2,6,2.9,6,4v12c0,1.1,0.9,2,2,2h12c1.1,0,2-0.9,2-2V4C22,2.9,21.1,2,20,2z M19,11H9V9h10V11z M15,15H9v-2h6V15z M19,7H9V5h10V7z"/>
                </svg></span>
              </a></h3>
              <article class="info element-invisible">
                <h2 class="info-h2">' . t('Gain/Loss Summary') . '</h2>
                <ul>
                  <li>' . t('You have a capital gain (or loss) if you sell an asset for more (or less) than you paid for it.') . '</li>
                  <li>' . t('If you hold an asset for more than one year before selling it, your capital gain or loss is classified long-term for federal income tax purpose. If you hold it one year or less, your capital gain or loss is classified short-term.') . '</li>
                  <li>' . t('This information is important for tax reporting and tax planning purposes. You should consult your tax advisor about the tax implications of these transactions.') . '</li>
                </ul>
              </article>
              <div class="brokerage_info-container">
                <div class="t_row">
                  <div class="t_cell">' . t('Realized gains and losses') . '</div>
                  <div class="t_cell">' . t('on January 31, 2015 ($)') . '</div>
                  <div class="t_cell">' . t('Year to date ($)') . '</div>
                  <div class="t_cell">' . t('Unrealized gains and losses  as of January 31, 2015') . '</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Short term') . '</div>
                  <div class="t_cell">' . t('$3,000') . '</div>
                  <div class="t_cell">' . t('$3,000') . '</div>
                  <div class="t_cell">&ndash;</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Long term') . '</div>
                  <div class="t_cell">&ndash;</div>
                  <div class="t_cell">&ndash;</div>
                  <div class="t_cell">' . t('$5,000') . '</div>
                </div>
              </div>
            </div>
          </div>
          <div class="col">
            <div class="clickable-container">
              <h3><a href="javascript:;" title="Click this icon to see additional info" class="clickable topLeft">
                ' . t('Holdings Summary') . '
                <span><svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="24px" height="24px" viewBox="0 0 24 24" enable-background="new 0 0 24 24" xml:space="preserve">
                  <path fill="none" d="M0,0h24v24H0V0z"/>
                  <path d="M4,6H2v14c0,1.1,0.9,2,2,2h14v-2H4V6z M20,2H8C6.9,2,6,2.9,6,4v12c0,1.1,0.9,2,2,2h12c1.1,0,2-0.9,2-2V4C22,2.9,21.1,2,20,2z M19,11H9V9h10V11z M15,15H9v-2h6V15z M19,7H9V5h10V7z"/>
                </svg></span>
              </a></h3>
              <article class="info element-invisible">
                <h2 class="info-h2">' . t('Holdings Summary') . '</h2>
                <ul>
                  <li>' . t('This section offers a big picture of the account holdings and the change in market value since the last statement, using starting values and ending values.') . '</li>
                  <li>' . t('This section may be broken down into each type of investment held in your account, such as:') . '
                    <ul>
                      <li>' . t('Cash and cash equivalents') . '</li>
                      <li>' . t('Equities (stock or options)') . '</li>
                      <li>' . t('Bonds (fixed income)') . '</li>
                      <li>' . t('Mutual funds') . '</li>
                      <li>' . t('Exchange Traded Funds (ETFs)') . '</li>
                      <li>' . t('Other types of securities or assets') . '</li>
                    </ul>
                  </li>
                </ul>
              </article>
              <div class="brokerage_info-container">
                <div class="t_row">
                  <div class="t_cell">&nbsp;</div>
                  <div class="t_cell">' . t('on January 1, 2015 ($)') . '</div>
                  <div class="t_cell">' . t('on January 31, 2015 ($)') . '</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Cash and Cash Equivalents') . '</div>
                  <div class="t_cell">' . t('$26,000') . '</div>
                  <div class="t_cell">' . t('$30,000') . '</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Equities/options') . '</div>
                  <div class="t_cell">' . t('$6,000') . '</div>
                  <div class="t_cell">' . t('$5,000') . '</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Corporate bonds') . '</div>
                  <div class="t_cell">&ndash;</div>
                  <div class="t_cell">&ndash;</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Municipal bonds') . '</div>
                  <div class="t_cell">&ndash;</div>
                  <div class="t_cell">&ndash;</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Certificates of deposit') . '</div>
                  <div class="t_cell">&ndash;</div>
                  <div class="t_cell">&ndash;</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('US Government bonds') . '</div>
                  <div class="t_cell">' . t('$15,000') . '</div>
                  <div class="t_cell">' . t('$15,000') . '</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Mutual Funds') . '</div>
                  <div class="t_cell">' . t('$53,000') . '</div>
                  <div class="t_cell">' . t('$25,000') . '</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Non-Classified') . '</div>
                  <div class="t_cell">&ndash;</div>
                  <div class="t_cell">&ndash;</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Sub-Total - Assets held at ACME') . '</div>
                  <div class="t_cell">' . t('$100,000') . '</div>
                  <div class="t_cell">' . t('$75,000') . '</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Assets not held at ACME') . '</div>
                  <div class="t_cell">' . t('$25,000') . '</div>
                  <div class="t_cell">' . t('$25,000') . '</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Total Assets') . '</div>
                  <div class="t_cell">' . t('$125,000') . '</div>
                  <div class="t_cell">' . t('$100,000') . '</div>
                </div>
              </div>
            </div>
            <div class="clickable-container">
              <h3><a href="javascript:;" title="Click this icon to see additional info" class="clickable topLeft">
                ' . t('Cash and Cash Equivalents Information') . '
                <span><svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="24px" height="24px" viewBox="0 0 24 24" enable-background="new 0 0 24 24" xml:space="preserve">
                  <path fill="none" d="M0,0h24v24H0V0z"/>
                  <path d="M4,6H2v14c0,1.1,0.9,2,2,2h14v-2H4V6z M20,2H8C6.9,2,6,2.9,6,4v12c0,1.1,0.9,2,2,2h12c1.1,0,2-0.9,2-2V4C22,2.9,21.1,2,20,2z M19,11H9V9h10V11z M15,15H9v-2h6V15z M19,7H9V5h10V7z"/>
                </svg></span>
              </a></h3>
              <article class="info element-invisible">
                <h2 class="info-h2">' . t('Cash and Cash Equivalents') . '</h2>
                <ul>
                  <li>' . t('Cash and cash equivalents are assets that are cash or can be converted into cash almost immediately. Examples include checks received but not yet deposited, cash held in FDIC-insured checking and savings accounts, money market funds, and other short-term, highly liquid investments with a maturity of three months or less, such as U.S. Treasury bills.') . '</li>
                  <li>' . t('These assets may be held by the clearing broker or elsewhere, such as at a bank or a mutual fund.') . '</li>
                </ul>
              </article>
              <div class="brokerage_info-container">
                <div class="t_row">
                  <div class="t_cell">&nbsp;</div>
                  <div class="t_cell">' . t('Available Funds ($)') . '</div>
                  <div class="t_cell">' . t('Rate (%)') . '</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Cash Equivalent Funds/Money Market') . '</div>
                  <div class="t_cell">' . t('$30,000') . '</div>
                  <div class="t_cell">' . t('0.01') . '</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Bank Insured Deposit Program (BIDP)') . '</div>
                  <div class="t_cell">&ndash;</div>
                  <div class="t_cell">' . t('0.02') . '</div>
                </div>
                <div class="t_row">
                  <div class="t_cell">' . t('Cash') . '</div>
                  <div class="t_cell">&ndash;</div>
                  <div class="t_cell">&ndash;</div>
                </div>
              </div>
            </div>
          </div>
        </section>';

    return $page_five;
}
