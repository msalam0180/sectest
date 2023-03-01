<?php
function brokerage_account_statement_page_one() {
  $page_one = '<section data-index="1" class="brokerage_account_section active-section">
          <h2>' . t('Brokerage Account Statement') . '</h2>
          <p style="margin-bottom: 1rem; padding:0;"><span>Click this icon </span><span><svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="18px" height="18px" viewBox="0 0 24 24" enable-background="new 0 0 24 24" xml:space="preserve">
                        <path fill="none" d="M0,0h24v24H0V0z"></path>
                        <path d="M4,6H2v14c0,1.1,0.9,2,2,2h14v-2H4V6z M20,2H8C6.9,2,6,2.9,6,4v12c0,1.1,0.9,2,2,2h12c1.1,0,2-0.9,2-2V4C22,2.9,21.1,2,20,2z M19,11H9V9h10V11z M15,15H9v-2h6V15z M19,7H9V5h10V7z"></path>
                      </svg></span><span> to see additional info</span><p>
          <div class="col">
            <div class="clickable-container">
              <p>
                <span class="address"><a href="javascript:;" title="Click this icon to see additional info" class="clickable topRight">
                ' . t('ACME BROKERS LLC') . '
                <span><svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="18px" height="18px" viewBox="0 0 24 24" enable-background="new 0 0 24 24" xml:space="preserve">
                    <path fill="none" d="M0,0h24v24H0V0z"/>
                    <path d="M4,6H2v14c0,1.1,0.9,2,2,2h14v-2H4V6z M20,2H8C6.9,2,6,2.9,6,4v12c0,1.1,0.9,2,2,2h12c1.1,0,2-0.9,2-2V4C22,2.9,21.1,2,20,2z M19,11H9V9h10V11z M15,15H9v-2h6V15z M19,7H9V5h10V7z"/>
                  </svg></span>
                </a></span>
                <article class="info element-invisible">
                  <h2 class="info-h2">' . t('General Account Information') . '</h2>
                  <ul>
                    <li>' . t('This section contains basic account information, such as the name of the account owner, the time period covered by the statement, and the account number. It will usually include contact information for your financial professional.') . '</li>
                  </ul>
                  <p><span class="alert">' . t('Don\'t be afraid to ask! ') . '</span>' . t('Don\'t hesitate to ask your financial professional to explain or provide more detail about any information in your account statement. You are paying them to provide this service.') . '</p>
                  <p><span class="alert">' . t('Important: ') . '</span>' . t('Ask about trades you don’t remember approving or any unexplained fees or commissions that are shown on the statement.') . '</p>
                </article>
                <span class="address">' . t('456 Financial Center Ave.') . '</span>
                <span class="address">' . t('Downtown, USA 12345') . '</span>
                <span class="address">' . t('www.acmebrokers.com') . '</span>
              </p>
            </div>
            <div>
              <p>
                <span class="address">' . t('Account Holder:') . '</span>
    	          <span class="address">' . t('Mr. and Mrs. J. Doe') . '</span>
    	          <span class="address">' . t('123 Main St.') . '</span>
    	          <span class="address">' . t('Anywhere, USA 67890') . '</span>
              </p>
            </div>
            <div>
              <div class="clickable-container">
                <h3>
                  <a href="javascript:;" title="Click this icon to see additional info" class="clickable topRight">' . t('From your Introducing Broker') . '
                    <span><svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="24px" height="24px" viewBox="0 0 24 24" enable-background="new 0 0 24 24" xml:space="preserve">
                      <path fill="none" d="M0,0h24v24H0V0z"/>
                      <path d="M4,6H2v14c0,1.1,0.9,2,2,2h14v-2H4V6z M20,2H8C6.9,2,6,2.9,6,4v12c0,1.1,0.9,2,2,2h12c1.1,0,2-0.9,2-2V4C22,2.9,21.1,2,20,2z M19,11H9V9h10V11z M15,15H9v-2h6V15z M19,7H9V5h10V7z"/>
                    </svg></span>
                  </a>
                </h3>
                <article class="info element-invisible">
                  <h2 class="info-h2">' . t('What is an Introducing Broker?') . '</h2>
                  <ul>
                    <li>' . t('An <strong>introducing broker</strong> takes orders for securities transactions but does not clear them or hold customer assets.  They often work directly with the customer (providing advice or making recommendations), while the job of clearing trades and holding the customer’s cash and securities is handled by another firm, usually called a carrying or clearing broker.  You may not have an introducing broker because some brokers clear their own transactions and hold customer assets without an introducing broker involved.') . '</li>
                  </ul>
                </article>
                <div>
                  <p>
                    <span class="address">' . t('Office servicing your account:') . '</span>
                    <span class="address">' . t('Jane Smith, Financial Advisor') . '</span>
                    <span class="address">' . t('ACME Brokers, Branch Office') . '</span>
                    <span class="address">' . t('777 Business Ave.') . '</span>
                    <span class="address">' . t('Anywhere, USA 67890') . '</span>
                    <span class="address">' . t('555-123-4567 | jsmith@acmebrokers.com') . '</span>
                  </p>
                </div>
              </div>
            </div>
          </div>
          <div class="col">
            <p>
              <span class="address">' . t('Period Ending:  January 31, 2015') . '</span>
              <span class="address">' . t('Account No. 1234567XYZ') . '</span>
            </p>
            <div class="brokerage_info-container">
              <h4>' . t('Asset Value') . '</h4>
              <div class="t_row">
                <div class="t_cell">' . t('Cash Equivalents') . '</div>
                <div class="t_cell">' . t('$30,000') . '</div>
              </div>
              <div class="t_row">
                <div class="t_cell">' . t('Portfolio Assets held at ACME Brokers') . '</div>
                <div class="t_cell">' . t('$45,000') . '</div>
              </div>
              <div class="t_row">
                <div class="t_cell">' . t('Portfolio Assets not held at ACME Brokers') . '</div>
                <div class="t_cell">' . t('$25,000') . '</div>
              </div>
              <div class="t_row">
                <div class="t_cell">' . t('Total Portfolio Value as of January 31, 2015') . '</div>
                <div class="t_cell">' . t('$100,000') . '</div>
              </div>
              <div class="t_row">
                <div class="t_cell">' . t('Total Portfolio Value as of January 1, 2015') . '</div>
                <div class="t_cell">' . t('$125,000') . '</div>
              </div>
            </div>
            <div>
              <div class="clickable-container">
                <h3>
                  <a href="javascript:;" title="Click this icon to see additional info" class="clickable bottomLeft">' . t('Primary Investment Objective') . '
                    <span><svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="24px" height="24px" viewBox="0 0 24 24" enable-background="new 0 0 24 24" xml:space="preserve">
                      <path fill="none" d="M0,0h24v24H0V0z"/>
                      <path d="M4,6H2v14c0,1.1,0.9,2,2,2h14v-2H4V6z M20,2H8C6.9,2,6,2.9,6,4v12c0,1.1,0.9,2,2,2h12c1.1,0,2-0.9,2-2V4C22,2.9,21.1,2,20,2z M19,11H9V9h10V11z M15,15H9v-2h6V15z M19,7H9V5h10V7z"/>
                    </svg></span>
                  </a>
                </h3>
                <article class="info element-invisible">
                  <h2 class="info-h2">' . t('Investment Objective') . '</h2>
                  <ul>
                    <li>' .t('Your financial professional may ask you about your investment goals and tolerance for risk. Investment goals and risk tolerance may range from those that preserve capital and generate income to those that are more aggressive and risky.  Brokers offer investments to meet a range of investment objectives.  Discuss with your financial professional which investment objective is right for you and let your broker know if your financial circumstances change so you can consider whether it makes sense to change your investment objective.') . '</li>
                  </ul>
                </article>
                <p>' . t('Your Primary Investment Objective is  Income') . '</p>
                <p>' . t('If you have questions concerning your investment objectives, please contact your introducing broker') . '</p>
              </div>
            </div>
          </div>
          <div>
            <div class="clickable-container cf col">
              <h3><a href="javascript:;" title="Click this icon to see additional info" class="clickable bottomRight">
                ' . t('Cleared Through:') . '
                <span><svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="24px" height="24px" viewBox="0 0 24 24" enable-background="new 0 0 24 24" xml:space="preserve">
                  <path fill="none" d="M0,0h24v24H0V0z"/>
                  <path d="M4,6H2v14c0,1.1,0.9,2,2,2h14v-2H4V6z M20,2H8C6.9,2,6,2.9,6,4v12c0,1.1,0.9,2,2,2h12c1.1,0,2-0.9,2-2V4C22,2.9,21.1,2,20,2z M19,11H9V9h10V11z M15,15H9v-2h6V15z M19,7H9V5h10V7z"/>
                </svg></span>
              </a></h3>
              <article class="info element-invisible">
                <h2 class="info-h2">' . t('What is a Carrying or Clearing Broker?') . '</h2>
                <ul>
                  <li>' . t('A <strong>carrying</strong> or <strong>clearing</strong> broker, often called a clearing firm, stands between an introducing broker and the exchanges.  It executes trades, prepares trade confirmations, settles money related to trades, and arranges for the securities to be transferred to the customer’s account. It also may hold customers’ cash and securities.') . '</li>
                  <li>' . t('Some brokers clear their own transactions and hold customer assets with no introducing broker involved.') . '</li>
                </ul>
                <p class="alert">' . t('Contact information for your clearing broker must be shown on your account statement.') . '</p>
              </article>
              <p>' . t('ACME CLEARING, INC.:') . '</p>
              <span class="address">' . t('222 Commerce Street') . '</span>
              <span class="address">' . t('Downtown, USA 12345') . '</span>
              <span>' . t('555-456-7890') . '<br />' . t('www.acmeclearing.com') . '</span>
          </div>
        </div>
        <div class="clickable-container important-info">
          <h3 class="important-info-h3"><a href="javascript:;" title="Click this icon to see additional info" class="clickable mid">' . t('Important') . '
            <span><svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="24px" height="24px" viewBox="0 0 24 24" enable-background="new 0 0 24 24" xml:space="preserve">
              <path fill="none" d="M0,0h24v24H0V0z"/>
              <path d="M4,6H2v14c0,1.1,0.9,2,2,2h14v-2H4V6z M20,2H8C6.9,2,6,2.9,6,4v12c0,1.1,0.9,2,2,2h12c1.1,0,2-0.9,2-2V4C22,2.9,21.1,2,20,2z M19,11H9V9h10V11z M15,15H9v-2h6V15z M19,7H9V5h10V7z"/>
            </svg></span>
          </a></h3>
          <article class="info element-invisible">
            <h2 class="info-h2">' . t('Carefully review your trade confirmations and your account statements!') . '</h2>
            <p>' . t('If you believe assets are missing from your account, or that a trade or transaction was made in error, to best protect your interests contact the introducing broker (if you have one) and the clearing firm by phone <em>and in writing</em>.') . '</p>
          </article>
        </div>
        </section>';

        return $page_one;
}
