<?php

function brokerage_account_statement_nav() {

  $nav_content = '<nav class="section-selector">
        <ol>
          <li><a href="javascript:;" data-page="prev">' . t('Prev') . '</a></li>
          <li><a href="javascript:;" data-page="1" class="current">' . t('1') . '</a></li>
          <li><a href="javascript:;" data-page="2">' . t('2') . '</a></li>
          <li><a href="javascript:;" data-page="3">' . t('3') . '</a></li>
          <li><a href="javascript:;" data-page="4">' . t('4') . '</a></li>
          <li><a href="javascript:;" data-page="5">' . t('5') . '</a></li>
          <li><a href="javascript:;" data-page="6">' . t('6') . '</a></li>
          <li><a href="javascript:;" data-page="next">' . t('Next') . '</a></li>
        </ol>
      </nav>';
  return $nav_content;
}
