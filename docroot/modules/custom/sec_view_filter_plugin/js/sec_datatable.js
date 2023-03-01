/**
 * @file
 * Contains custom initializer for SecDataTable;
 */

(function ($, Drupal, drupalSettings) {
  'use strict';
  Drupal.behaviors.SecDataTable = {
    attach: function (context, settings) {

      // Set the context;
      var $context = $('.en-datatable:not(.datatable-paginate) table');
      $context.find('tbody td.views-field-field-person').find('*').not('h4,i,em,span').contents().unwrap().wrap();
      $context.once('dt').each(
        function () {
          var worktable = $(this);
          var numHeadColumns = worktable.find('thead tr th').length;
          var rowsToValidate = worktable.find('tbody tr');
          rowsToValidate.each(
            function (i) {
              for (i = $(this).find('td').length; i < numHeadColumns; i++) {
                $(this).append('<td class="hidden"></td>');
              }
            }
          );
        }
      );

      // Set the context;
      var $context2 = $('.en-datatable.datatable-paginate table');
      $context.find('tbody td.views-field-field-person').find('*').not('h4,i,em,span').contents().unwrap().wrap();
      $context.once('dt').each(
        function () {
          var worktable = $(this);
          var numHeadColumns = worktable.find('thead tr th').length;
          var rowsToValidate = worktable.find('tbody tr');
          rowsToValidate.each(
            function (i) {
              for (i = $(this).find('td').length; i < numHeadColumns; i++) {
                $(this).append('<td class="hidden"></td>');
              }
            }
          );
        }
      );

      var dtsettings = {
        isDatatable: $context.length === 1 || $context2.length === 1,
        isAdminView: $('.isAdmin table').length === 1,
        noRowGrouping: $('.noRowGrouping table').length === 1,
        isSearchView: $('.content-search table').length === 1,
        defaultOrdering: $('.noOrdering table').length !== 1,
        hasPublishDateCol: $context.find('thead th#view-field-publish-date-table-column,#view-field-sec-event-date-table-column').length === 1 || $context.find('thead th#view-field-publish-date-table-column,#view-field-sec-event-date-table-column').length === 1
      };

      if (dtsettings.isDatatable) {
        var tablesorter = $('.tablesorter-header-inner');
        if (tablesorter && tablesorter.is('.tablesorter-header-inner')) {
          tablesorter.removeClass('tablesorter-header-inner');
        }
      }

      $.extend(
        $.fn.dataTableExt.oSort, {
          'html-pre': function (a) {
            return a.replace(/<.*?>| /g, '').replace(/[a-zA-Z]*\.*:/, '').trim().toLowerCase();
          },
        }
      );

      var sortIndex = dtsettings.noRowGrouping ? 0 : 1;

      var columnDefs = [
        dtsettings.isAdminView || dtsettings.noRowGrouping ? {visible: true, targets: 0} : {visible: false, targets: 0},
        dtsettings.isSearchView ? {orderable: false, targets: [0, 9]} : {},
        dtsettings.hasPublishDateCol ? {type: 'natural', targets: sortIndex} : {type: 'html', targets: '_all'},
      ];

      var table = $context.DataTable( // eslint-disable-line new-cap
        {
          columnDefs: columnDefs,
          order: [
            dtsettings.hasPublishDateCol ? [sortIndex, 'desc'] : [sortIndex, 'asc']
          ],
          bPaginate: false,
          bFilter: false,
          autoWidth: false,
          bInfo: false,
          searching: false,
          ordering: dtsettings.defaultOrdering,
          retrieve: true,
          bUseRendered: false,
          drawCallback: function (settings) {
            if (dtsettings.isAdminView || dtsettings.noRowGrouping) {
              return false;
            }
            var api = this.api();
            var rows = api.rows({page: 'current'}).nodes();
            var last = null;
            var col = $('.en-datatable table').find('thead>tr>th').length;
            api.column(0, {page: 'current'}).data().each(
              function (group, i) {
                if (last !== group) {
                  $(rows).eq(i).before(
                    '<tr class="group" scope="col"><td colspan=' + col + '>' + group + '</td></tr>'
                  );
                  last = group;
                }
              }
            );
          },
          fnInitComplete: function () {
            $('.en-datatable').show();
            this.fnAdjustColumnSizing();
          }
        }
      );

      /**
       *  Handle natural sort only;
       */
      // set column 3 to be sorted naturally;
      if (table.context.length > 0) {
        for (var key in table.context[0].aoColumns) {
          if (table.context[0].aoColumns[key].sTitle.indexOf('Release No') !== -1) {
            table.context[0].aoColumns[key].natural = true;
          }
        }
        var tableContext = table.context[0];
        var columns = tableContext.aoColumns;
        for (var i in columns) {
          if (columns[i].hasOwnProperty('natural')) {
            table.context[0].aoColumns[3].sType = 'natural';
          }
        }
      }

      var records = $('.en-datatable.datatable-paginate table tbody tr').length;
      if ($('.en-datatable.datatable-paginate table tbody tr .views-empty').length === 0) {

        var order = 'desc';

        if (typeof drupalSettings.sec_datatable.sortIndex !== 'undefined') {
          sortIndex = drupalSettings.sec_datatable.sortIndex;
        }

        if (typeof drupalSettings.sec_datatable.sortOrder !== 'undefined') {
          order = drupalSettings.sec_datatable.sortOrder;
        }

        var table2 = $context2.DataTable( // eslint-disable-line new-cap
          {
            columnDefs: drupalSettings.sec_datatable.columnDefs,
            order: [
              [sortIndex, order]
            ],
            bPaginate: (typeof drupalSettings.sec_datatable.paginate !== 'undefined') ? drupalSettings.sec_datatable.paginate : records > 100,
            bLengthChange: false,
            iDisplayLength: 100,
            bFilter: false,
            autoWidth: false,
            bInfo: (typeof drupalSettings.sec_datatable.showInfo !== 'undefined') ? drupalSettings.sec_datatable.showInfo : true,
            searching: false,
            ordering: dtsettings.defaultOrdering,
            retrieve: true,
            bUseRendered: false,
            drawCallback: function (settings) {
              if (dtsettings.isAdminView || dtsettings.noRowGrouping || drupalSettings.sec_datatable.noRowGrouping) {
                return false;
              }
              var api = this.api();
              var rows = api.rows({page: 'current'}).nodes();
              var last = null;
              var col = $('.en-datatable.datatable-paginate table').find('thead>tr>th').length;
              api.column(0, {page: 'current'}).data().each(
                function (group, i) {
                  if (last !== group) {
                    $(rows).eq(i).before(
                      '<tr class="group" scope="col"><td colspan=' + col + '>' + group + '</td></tr>'
                    );
                    last = group;
                  }
                }
              );
            },
            fnInitComplete: function () {
              $('.en-datatable.datatable-paginate').show();
              $('.en-datatable.datatable-paginate .view--below-footer--count').hide();
              this.fnAdjustColumnSizing();
            }

          }
        );


        if (table2.context.length > 0) {
          for (var key in table2.context[0].aoColumns) {
            if (table2.context[0].aoColumns[key].sTitle.indexOf('Release No') !== -1) {
              table2.context[0].aoColumns[key].natural = true;
            }
          }
          var tableContext2 = table2.context[0];
          var columns2 = tableContext2.aoColumns;
          for (var columnIndex in columns2) {
            if (columns2[columnIndex].hasOwnProperty('natural')) {
              table2.context[0].aoColumns[3].sType = 'natural';
            }
          }
        }

        $('.en-datatable.datatable-paginate .dataTables_paginate').append($('.en-datatable.datatable-paginate .dataTables_info'));
        $('.en-datatable.datatable-paginate .more-link').after($('.en-datatable.datatable-paginate .dataTables_paginate'));
      }
      else {
        $('.en-datatable.datatable-paginate').show();
      }

      if (dtsettings.isAdminView) {
        return false;
      }
      // Only show grouped col if the Date col is clicked;
      var th = $('.en-datatable table th');
      $.each(
        th, function (index, value) {
          if (index !== 0) {
            $(this).click(
              function () {
                $('tr.group').hide();
              }
            );
          }
        }
      );

      $('.en-datatable.datatable-paginate table').on('DOMSubtreeModified', function(){
        if ($('.en-datatable.datatable-paginate table th').first().hasClass('sorting')) {
          $('.en-datatable.datatable-paginate table tr.group').hide();
        }
      });

    }
  };
})(jQuery, Drupal, drupalSettings);

