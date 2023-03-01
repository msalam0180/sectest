jQuery(
  function ($) {
    $(document).ready(
      function () {
        function edgarTTMenuResizer() {
          var edgarForm = $('#edgar form');
          var ttMenuDD = $('.tt-menu');
          var contentContainer = $('#content');

          if ((($(window).width() - contentContainer.width()) / 2) >= 10) {
            ttMenuDD.css({width: 292}); // maximum width before cutoff
          }
          else {
            ttMenuDD.css({width: edgarForm.width()});
          }
        }

        $(window).on('resize load', edgarTTMenuResizer);
        $(document).on('ready load', edgarTTMenuResizer);

        $('#fast-search').hide();

        // Get companies from companies.json and initialize typeahead
        $.ajax(
          {
            url: 'https://www.sec.gov/files/company_tickers.json',
            dataType: 'json',
            success: function (data, textStatus, jqXHR) {
              var companies = [];
              var tickers = [];
              $.each(
                data, function (i, company) {
                  companies.push(company.title + ' (' + company.ticker + ')');
                  tickers.push(company.ticker.toLowerCase());
                }
              );

              /* eslint-disable no-undef */
              var engine = new Bloodhound(
                {
                  datumTokenizer: Bloodhound.tokenizers.nonword,
                  queryTokenizer: Bloodhound.tokenizers.whitespace,
                  local: companies
                }
              );
              /* eslint-enable no-undef */

              $('#company-name').typeahead(
                {
                  highlight: true,
                  hint: false
                },
                {
                  name: 'companies',
                  source: engine
                }
              );

              $('#edgar-search-button').click(
                function (e) {
                  e.preventDefault();
                  var searchTerm = $('#company-name').val();
                  if ($.inArray(searchTerm, companies) > -1) {
                    var ticker = searchTerm.split('(')[1].split(')')[0];
                    $('#cik').val(ticker);
                    $('#fast-search').submit();
                  }
                  else if ($.inArray(searchTerm.toLowerCase(), tickers) > -1) {
                    $('#cik').val(searchTerm);
                    $('#fast-search').submit();
                  }
                  else {
                    $('#edgar-search').submit();
                  }
                }
              );

              $('#company-name').bind(
                'keypress', function (e) {
                  if (e.keyCode == 13) {
                    $('#edgar-search-button').click();
                  }
                }
              );

              $('#company-name').bind(
                'typeahead:select', function (ev, suggestion) {
                  $('#company-name').val(suggestion);
                  $('#edgar-search-button').click();
                }
              );

              // Bind focus and blur events to company name search field
              $('#company-name').focus(
                function () {
                  if ($(this).val() == 'Name or Ticker') {
                    $(this).val('');
                    $(this).css('color', '#333');
                  }
                }
              );

              $('#company-name').blur(
                function () {
                  $(this).css('color', '#b1b1b1');
                  if ($(this).val() == '') {
                    $(this).val('Name or Ticker');
                    $(this).css('color', '#b1b1b1');
                  }
                  else if ($(this).val() != '' && $(this).val() != 'Name or Ticker') {
                    $(this).css('color', '#333');
                  }
                }
              );
            }
          }
        );
      }
    );
  }
);
