var splitRegex = /\r\n|\r|\n/g;
jsPDF.API.textEx = function(text, x, y, hAlign, vAlign) {
  var fontSize = this.internal.getFontSize() / this.internal.scaleFactor;
  // As defined in jsPDF source code
  var lineHeightProportion = 1.15;
  var splittedText = null;
  var lineCount = 1;
  if (vAlign === 'middle' || vAlign === 'bottom' || hAlign === 'center' || hAlign === 'right') {
    splittedText = typeof text === 'string' ? text.split(splitRegex) : text;
    lineCount = splittedText.length || 1;
  }
  // Align the top
  y += fontSize * (2 - lineHeightProportion);
  if (vAlign === 'middle')
    y -= (lineCount / 2) * fontSize;
  else if (vAlign === 'bottom')
    y -= lineCount * fontSize;
  if (hAlign === 'center' || hAlign === 'right') {
    var alignSize = fontSize;
    if (hAlign === 'center')
      alignSize *= 0.5;
    if (lineCount > 1) {
      for (var iLine = 0; iLine < splittedText.length; iLine++) {
        this.text(splittedText[iLine], x - this.getStringUnitWidth(splittedText[iLine]) * alignSize, y - 3);
        y += fontSize;
      }
      return this;
    }
    if (text.constructor == Array && text.length == 1) {
      text = text[0];
    }
    x -= this.getStringUnitWidth(text) * alignSize;
  }
  this.text(text, x, y - 3);
  return this;
};
jQuery(function($) {
  $("label.labelForRuleChecks").tooltip();
  $('input.FileNumber_Format').inputmask({
    mask: [{
      "mask": "###-###############"
    }],
    greedy: false,
    placeholder: "",
    definitions: {
      '#': {
        validator: "[0-9]",
        cardinality: 1
      }
    }
  });
  //Input controls
  $(".currencycontrol").autoNumeric('init', {
    digitGroupSeparator: ',',
    aNeg: '',
    decimalPlacesOverride: 2,
    mNum: 10000,
    currencySymbol: '$'
  });
  $(".integercontrol").autoNumeric('init', {
    digitGroupSeparator: ',',
    aNeg: '',
    decimalPlacesOverride: 0,
    mNum: 10000
  });
  $(".ratecontrol").autoNumeric('init', {
    digitGroupSeparator: '',
    aNeg: '',
    decimalPlacesOverride: 7,
    mNum: 10000
  });
  $(".decimalcontrol").autoNumeric('init', {
    digitGroupSeparator: ',',
    aNeg: '',
    decimalPlacesOverride: 2,
    mNum: 10000
  });
});
var pageNumber = 1,
  digitsOnly = /[1234567890]/g,
  integerOnly = /[0-9\.]/g,
  alphaOnly = /[A-Za-z]/g;

function restrictCharacters(myfield, e, restrictionType) {
  if (!e) var e = window.event
  if (e.keyCode) code = e.keyCode;
  else if (e.which) code = e.which;
  var character = String.fromCharCode(code);
  if (code == 27) {
    this.blur();
    return false;
  }
  if (!e.ctrlKey && code != 9 && code != 8 && code != 36 && code != 37 && code != 38 && (code != 39 || (code == 39 && character == "'")) && code != 40) {
    if (character.match(restrictionType)) {
      return true;
    } else {
      return false;
    }
  }
}
//global info
var gInfo = "The Registration Fee Estimator is intended to assist filers in estimating filing fees and provide general guidance on preparing the calculation of Registration Fee Table and related footnotes. Users should complete the Data Entry Screen, then select Calculate Fees. Based on the data provided, the subsequent screen will display values and content that may be used, if accurate, to complete  the Registration Fee Calculation Table and associated footnotes   and EDGAR entries. Additional information related to the calculation logic can be viewed by selecting Fee Calculation Break Down. The current version of the tool is designed to accommodate only certain form types and rule references.<br><br>Any questions related to the tool should be directed to the Filing Fees Branch via email at FilingFees@SEC.gov or at (202)551-8989.";
//global disclaimer
var gDisclaimer = "<strong>Disclaimer:</strong> The Registration Fee Estimator is intended to assist filers in estimating filing fees and provide general guidance on preparing the calculation of Registration Fee Table and related footnotes. There can be no assurance that the estimate or guidance provided will be current or correct, and this tool should not be relied upon as an official calculation or verification of required fees. The Commission assumes no responsibility and disclaims all liability for inaccurate payments made or other reliance placed on the information provided by the tool. Registrants that choose to use this tool remain responsible for paying all required fees and accurately including all required information in their filings. The Registration Fee Estimator is not a rule, regulation, or statement of the Commission. If you have questions concerning the meaning or application of a particular law or rule, please consult an attorney who specializes in securities law.";
//global help text
var gHelpText = {
  FormType: "Form Type combo box to change the selection use the arrow keys.  This refers to the type of SEC form that is being used to register securities.",
  FilingDate: "This refers to the expected date of filing for the registration statement being submitted.",
  Rule457o: "Rule 457(o): Where an issuer registers an offering of securities, the registration fee may be calculated on the basis of the maximum aggregate offering price of all the securities listed in the “Calculation of Registration Fee” table. The number of shares or units of securities need not be included in the “Calculation of Registration Fee” Table. If the maximum aggregate offering price increases prior to the effective date of the registration statement, a pre-effective amendment must be filed to increase the maximum dollar value being registered and the additional filing fee shall be paid.",
  Rule415a6: "Rule 415(a)(6): Prior to the end of the three-year period described in paragraph (a)(5) of this section, an issuer may file a new registration statement covering securities described in such paragraph (a)(5) of this section, which may, if permitted, be an automatic shelf registration statement. The new registration statement and prospectus included therein must include all the information that would be required at that time in a prospectus relating to all offering(s) that it covers. Prior to the effective date of the new registration statement (including at the time of filing in the case of an automatic shelf registration statement), the issuer may include on such new registration statement any unsold securities covered by the earlier registration statement by identifying on the bottom of the facing page of the new registration statement or latest amendment thereto the amount of such unsold securities being included and any filing fee paid in connection with such unsold securities, which will continue to be applied to such unsold securities. The offering of securities on the earlier registration statement will be deemed terminated as of the date of effectiveness of the new registration statement.",
  Rule429: "Rule 429: Where a registrant has filed two or more registration statements, it may file a single prospectus in the latest registration statement in order to satisfy the requirements of the Act and the rules and regulations thereunder for that offering and any other offering(s) registered on the earlier registration statement(s). The combined prospectus in the latest registration statement must include all of the information that currently would be required in a prospectus relating to all offering(s) that it covers. The combined prospectus may be filed as part of the initial filing of the latest registration statement, in a pre-effective amendment to it or in a post-effective amendment to it.",
  Rule457p: "Rule 457(p): Where all or a portion of the securities offered under a registration statement remain unsold after the offering's completion or termination, or withdrawal of the registration statement, the aggregate total dollar amount of the filing fee associated with those unsold securities (whether computed under § 230.457(a) or (o)) may be offset against the total filing fee due for a subsequent registration statement or registration statements. The subsequent registration statement(s) must be filed within five years of the initial filing date of the earlier registration statement, and must be filed by the same registrant (including a successor within the meaning of § 230.405), a majority-owned subsidiary of that registrant, or a parent that owns more than 50 percent of the registrant's outstanding voting securities. A note should be added to the “Calculation of Registration Fee” table in the subsequent registration statement(s) stating the dollar amount of the filing fee previously paid that is offset against the currently due filing fee, the file number of the earlier registration statement from which the filing fee is offset, and the name of the registrant and the initial filing date of that earlier registration statement.",
  Rule457c: "Rule 457(c): Where securities are to be offered at prices computed upon the basis of fluctuating market prices, the registration fee is to be calculated upon the basis of the price of securities of the same class, as follows: either the average of the high and low prices reported in the consolidated reporting system (for exchange traded securities and last sale reported over-the-counter securities) or the average of the bid and ask price (for other over-the-counter securities) as of a specified date within 5 business days prior to the date of filing the registration statement.",
  Rule457a: "Rule 457(a): If a filing fee based on a bona fide estimate of the maximum offering price, computed in accordance with this rule where applicable, has been paid, no additional filing fee shall be required as a result of changes in the proposed offering price. If the number of shares or other units of securities, or the principal amount of debt securities to be offered is increased by an amendment filed prior to the effective date of the registration statement, an additional filing fee, computed on the basis of the offering price of the additional securities, shall be paid. There will be no refund once the statement is filed.",
  SecurityType: "This refers to the description of the securities that will be registered.",
  SecurityTitle: "This refers to the name of the security that is being registered.",
  AmtToBeReg: "This refers to the number of shares (or units) of the securities that will be registered.",
  PricePerShare: "This refers to the Maximum price per security  (or per unit) of the securities that will be registered.  If the securities will be offered at a discount or with a premium, the Proposed Maximum Offering Price per Unit refers to the percentage (discounted or with a premium) at which they will be offered.",
  MaxAggOffPrice: "This refers to the total dollar value of the securities being offered for sale.  If the securities will be offered at a discount or with a premium, this total dollar value will be net of the discount, or inclusive of the premium.",
  FormType415a6: "This refers to the form type that was used to register the expiring unsold securities from the referenced previous registration statement, that are now being carried forward to this new registration statement.",
  EffecDateFiling415a6: "Date the previously registered shares were deemed effective by the SEC",
  FilingDate415a6: "This refers to the date of filing of the referenced previous registration statement that was filed to register the expiring unsold securities, that are now being carried forward to this new registration statement.",
  AggOffAmtUnsoldCF415a6: "Aggregate Amount of unsold securities being brought forward from a previous registration statement to a new registration statement due to the expiring date of the previous registration statement",
  AmtUnsoldCF415a6: "Amount of unsold securities being brought forward from a previous registration statement to a new registration statement due to the expiring date of the previous registration statement.",
  FileNum415a6: "Number assigned to the registration statement from which unsold shares are being carried forward.",
  CIK457p: "The Central Index Key (CIK) that identifies the registrant of the filing that is now being relied upon as the source of the offset under Rule 457(p).",
  FormType457p: "Form Type of the filing being referenced as an offset",
  AmtAvailOffset: "Dollar Amount of the offset being referenced.",
  UnsoldMaxAggOff457p: "Amount of securities that remain unsold from the filing(s) being referenced as an offset.",
  FilingDate457p: "Filing dates of previous registration statements from which offsets were derived.",
  AggAmtPros: "Total aggregate dollar amount of securities being covered by the prospectus.",
  PriorRegFileNum429: "File number of the unsold securities that are being combined into the current prospectus",
  NetFeeModal429Hover: "Any unsold securities being combined under the current Prospectus (pursuant to Rule 429) are not included the Registration Fee calculation, but should be fully detailed in the accompanying footnotes.",
  HlpLowSharePrice: "This is field can be populated with the lowest price per share value of the security being registered during the five day period prior to the filing submission.",
  HlpHighSharePrice: "This is field can be populated with the highest price per share value of the security being registered during the five day period prior to the filing submission.",
  Hlp429_UnsoldSecuritiesPrior: "The total number of unsold securities that were already registered and are now being combined under the current prospectus.",
  Hlp429_UnsoldShares: "The total dollar value of the unsold securities that were already registered and are now being combined under the current prospectus.",
  Hlp429_FileNumberPrior: "Number assigned to the registration statement that was initially used to register the securities that are now being combined under the current prospectus.",
  Hlp429_PriorRegFilingDate: "This refers to the form type of prior registration statement to which the combined prospectus relates.",
  MaxPriceSecType: "Form Type combo box to change the selection use the arrow keys. This refers to the maximum price per security."
}
//global fee rates
var gFeeRate = [{
    startDate: new Date("10/1/2011"),
    endDate: new Date("09/30/2012"),
    rate: 0.0001146000
  },
  {
    startDate: new Date("12/27/2010"),
    endDate: new Date("09/30/2011"),
    rate: 0.0001161
  },
  {
    startDate: new Date("12/21/2009"),
    endDate: new Date("12/26/2010"),
    rate: 0.0000713
  },
  {
    startDate: new Date("03/16/2009"),
    endDate: new Date("12/20/2009"),
    rate: 0.0000558
  },
  {
    startDate: new Date("12/31/2007"),
    endDate: new Date("03/15/2009"),
    rate: 0.0000393
  },
  {
    startDate: new Date("02/20/2007"),
    endDate: new Date("12/30/2007"),
    rate: 0.0000307
  },
  {
    startDate: new Date("11/27/2005"),
    endDate: new Date("02/19/2007"),
    rate: 0.000107
  },
  {
    startDate: new Date("12/13/2004"),
    endDate: new Date("11/26/2005"),
    rate: 0.0001177
  },
  {
    startDate: new Date("01/28/2004"),
    endDate: new Date("12/12/2004"),
    rate: 0.0001267
  },
  {
    startDate: new Date("02/25/2003"),
    endDate: new Date("01/27/2004"),
    rate: 0.0000809
  },
  {
    startDate: new Date("10/01/2001"),
    endDate: new Date("02/24/2003"),
    rate: 0.000092
  },
  {
    startDate: new Date("12/21/2000"),
    endDate: new Date("09/30/2001"),
    rate: 0.00025
  },
  {
    startDate: new Date("11/29/1999"),
    endDate: new Date("12/20/2000"),
    rate: 0.000264
  },
  {
    startDate: new Date("10/22/1998"),
    endDate: new Date("11/28/1999"),
    rate: 0.000278
  },
  {
    startDate: new Date("11/28/1997"),
    endDate: new Date("10/21/1998"),
    rate: 0.000295
  },
  {
    startDate: new Date("10/01/1996"),
    endDate: new Date("11/27/1997"),
    rate: 0.00030303
  },
  {
    startDate: new Date("05/20/1995"),
    endDate: new Date("09/30/1996"),
    rate: 0.000344828
  },
  {
    startDate: new Date("10/11/1994"),
    endDate: new Date("05/19/1995"),
    rate: 0.00034483
  },
  {
    startDate: new Date("10/03/1994"),
    endDate: new Date("10/07/1994"),
    rate: 0.0002
  },
  {
    startDate: new Date("10/28/1993"),
    endDate: new Date("10/01/1994"),
    rate: 0.00034483
  },
  {
    startDate: new Date("10/01/1991"),
    endDate: new Date("10/27/1993"),
    rate: 0.0003125
  },
  {
    startDate: new Date("10/01/1989"),
    endDate: new Date("09/30/1991"),
    rate: 0.00025
  },
  {
    startDate: new Date("10/01/1980"),
    endDate: new Date("09/30/1989"),
    rate: 0.0002
  },
  {
    startDate: new Date("10/01/2012"),
    endDate: new Date("09/30/2013"),
    rate: 0.0001364
  },
  {
    startDate: new Date("10/01/2013"),
    endDate: new Date("09/30/2014"),
    rate: 0.0001288
  },
  {
    startDate: new Date("10/01/2014"),
    endDate: new Date("09/30/2015"),
    rate: 0.0001162
  },
  {
    startDate: new Date("10/01/2015"),
    endDate: new Date("09/30/2016"),
    rate: 0.0001007
  },
  {
    startDate: new Date("10/01/2016"),
    endDate: new Date("09/30/2017"),
    rate: 0.0001159
  }
];
//global master calculation; invoked after user clicks submit and used for both modals and pdf
var gMasterCalculation = {
  rulesSelected: "",
  netFeeModal: {
    chosenOorA: "a",
    _457a: {
      securityTitle: "",
      amtRegistered: "",
      amtCarriedForward: "",
      adjAmt: "",
      priceShare: "",
      maxAggOffering: "",
      subAggregate: "",
      totAggregate: "",
      feeRate: "",
      regFee: "",
      offset: "",
      netFee: "",
      _429Note: ""
    },
    _457o: {
      securityTitle: "",
      aggregate: "",
      aggCarriedForward: "",
      adjGrossAggregate: "",
      subAggregate: "",
      totAggregate: "",
      feeRate: "",
      regFee: "",
      offset: "",
      netFee: "",
      _429Note: ""
    }
  },
  dataEntryModal: {
    calcRegFee: {
      dataFields: "",
      romanNumeralHeadingAppend: "",
      securityTitle: "",
      amtRegistered: "",
      proposedMaxOffering: "",
      proposedMaxAggOffering: "",
      amtRegFee: ""

    },
    footNotes: {
      dataFields: "",
      filingFootnotes: ""
    },
    edgarHeader: {
      offAndFees: {
        dataFields: "",
        securityType: "",
        amtRegistered: "",
        proposedMaxOffering: "",
        proposedMaxAggOffering: ""
      },
      feeAndOffset: {
        dataFields: "",
        cik: "",
        formType: "",
        fileNumber: "",
        offsetFilingDate: "",
        amt: ""
      }
    }
  }
};
jQuery(function($) {
  $(document).ready(function() {

    var Hyphen = true;
    //after page loads call
    $(".article-content > div.content.aside").css("width", "100%"); //$('#main-content > div:nth-child(3).colspan-9.columns').removeClass("colspan-9").addClass("colspan-12"); // to change the main content width of SEC article..
    fadeOutAllScreens();
    $("#feeestimatorform").fadeIn(200);
    $("#spanFeeRateDisplay").html(gFeeRate[gFeeRate.length - 1].rate); // to display the fee rate below filing date.
    setDisclaimers(); //set disclaimers
    setDateControls(); //bind date controls
    setHelpHover(); //set help text
    setBoxesGrayedOut(); //gray out certain boxes
    //setInputControls();//set input controls for currency/integer, etc
    //$(document).foundation();//load foundation framework
    validationCheck(); //validate all input fields immediately to set the required fields
    //changing screens on click of buttons
    $(".dataEntry").on("click", function() {
      fadeOutAllScreens();
      $("#feeestimatorform").fadeIn(200);
    });
    $(".outputScreen").on("click", function() {
      fadeOutAllScreens();
      $("#dataEntryTab").fadeIn(200);
    });
    $(".feeBreakDown").on("click", function() {
      fadeOutAllScreens();
      $("#netFeeTableTab").fadeIn(200);
      if (gMasterCalculation.netFeeModal.chosenOorA === "a") {
        $("#tableNetFee457A").fadeIn(200);
      } else if (gMasterCalculation.netFeeModal.chosenOorA === "o") {
        $("#tableNetFee457O").fadeIn(200);
      }
    });
    $("#trCalcRegTableTop").on("mouseenter click", function() {
      $("#dataEntryCalRegFeeTable").css("background-color", "#F3F3F3");
      $("#dataEntryCalRegFeeTable").find("tr").css("background-color", "#F3F3F3");
    }).on("mouseleave", function() {
      $("#dataEntryCalRegFeeTable").css("background-color", "white");
      $("#dataEntryCalRegFeeTable").find("tr").css("background-color", "white");
    });
    $("#txtBidAskDtDate").on('blur', function() {
      setTimeout(function() {
        $(".spanMarketDateFrLabel").text($("#txtBidAskDtDate").val())
      }, 250);;
    });
    $(".exportPDF").on("click", function() {
      drawPDFModals();
    });
    // on maximum price per security based on bid/ask or hihg/low sale prices change
    $("#ddlMaxPriceSecType").on("change", function() {
      $("#lblLowAskPriceText").text("Low");
      $("#lblHighBidPriceText").text("High");
      $('label[for="txtMarketonWhichSalePriceRprtd"]').find('span').text("high/low");
      $('label[for="txtBidAskDtDate"]').find('span').text("high/low");
      if ($(this).find("option:selected").val() == "bidask") {
        $("#lblLowAskPriceText").text("Ask");
        $("#lblHighBidPriceText").text("Bid");
        $('label[for="txtMarketonWhichSalePriceRprtd"]').find('span').text("bid/ask");
        $('label[for="txtBidAskDtDate"]').find('span').text("bid/ask");
      }
    });
    //checkboxes click
    //need to trigger change when unchecking to remove 429 average so make it on("change"...
    $("body").on("change", "input[type=checkbox]", function() {
      var id = $(this).attr("id");
      validationCheck();
      if (anyCheckboxChecked() === false) {
        if ($("#txtRegAmount").val() != "") {
          $('label[for="txtRegAmount"]').removeClass("redasterisk");
        } else {
          $('label[for="txtRegAmount"]').addClass("redasterisk");
        }
        if ($("#txtSharePrice").val() != "") {
          $('label[for="txtSharePrice"]').removeClass("redasterisk");
        } else {
          $('label[for="txtSharePrice"]').addClass("redasterisk");
        }
      }
      //gray out boxes on 457(o)
      if (id.indexOf("457o") > -1) {
        if ($(this).is(":checked")) {
          $("#rchoice457a").attr("disabled", "disabled");
          $("#rchoice457c").attr("disabled", "disabled");
          $("#txtRegAmount").attr("readonly", true);
          $("#txtRegAmount").removeClass("input-disabled").addClass("input-disabled");
          $("#txtRegAmount").removeAttr("required");
          $('label[for="txtRegAmount"]').removeClass("redasterisk");
          $("#txtRegAmount").val("");
          $("#txtSharePrice").attr("readonly", true);
          $("#txtSharePrice").removeClass("input-disabled").addClass("input-disabled");
          $("#txtSharePrice").removeAttr("required");
          $('label[for="txtSharePrice"]').removeClass("redasterisk");
          $("#txtSharePrice").val("");
          $("#txtLowSharePrice").attr("readonly", true);
          $("#txtLowSharePrice").removeClass("input-disabled").addClass("input-disabled");
          $("#txtLowSharePrice").val("");
          $("#txtHighSharePrice").attr("readonly", true);
          $("#txtHighSharePrice").removeClass("input-disabled").addClass("input-disabled");
          $("#txtHighSharePrice").val("");
          $("#txt415a6_UnsoldSharesCF").attr("readonly", true);
          $("#txt415a6_UnsoldSharesCF").removeClass("input-disabled").addClass("input-disabled");
          $("#txt415a6_UnsoldSharesCF").removeAttr("required");
          $('label[for="txt415a6_UnsoldSharesCF"]').removeClass("redasterisk");
          $("#txt415a6_UnsoldSharesCF").val("");
          //remove gray box
          $("#txtMaxAggregate").attr("readonly", false);
          $("#txtMaxAggregate").removeClass("input-disabled");
          $("#txtMaxAggregate").attr("required", true);
          $('label[for="txtMaxAggregate"]').addClass("redasterisk");
          $("#txt415a6_AggregateOffering").attr("readonly", false);
          $("#txt415a6_AggregateOffering").removeClass("input-disabled");
          $("#txt415a6_AggregateOffering").attr("required", true);
          $('label[for="txt415a6_AggregateOffering"]').addClass("redasterisk");
        }
        //remove gray boxes
        else {
          $("#rchoice457a").attr("disabled", false);
          $("#rchoice457c").attr("disabled", false);
          $("#txtRegAmount").attr("readonly", false);
          $("#txtRegAmount").removeClass("input-disabled");
          $("#txtRegAmount").attr("required", true);
          $('label[for="txtRegAmount"]').addClass("redasterisk");
          $("#txtSharePrice").attr("readonly", false);
          $("#txtSharePrice").removeClass("input-disabled");
          $("#txtSharePrice").attr("required", true);
          $('label[for="txtSharePrice"]').addClass("redasterisk");
          $("#txtLowSharePrice").attr("readonly", false);
          $("#txtLowSharePrice").removeClass("input-disabled");
          $("#txtHighSharePrice").attr("readonly", false);
          $("#txtHighSharePrice").removeClass("input-disabled");
          $("#txt415a6_UnsoldSharesCF").attr("readonly", false);
          $("#txt415a6_UnsoldSharesCF").removeClass("input-disabled");
          $("#txt415a6_UnsoldSharesCF").attr("required", true);
          $('label[for="txt415a6_UnsoldSharesCF"]').addClass("redasterisk");
          //add gray box
          $("#txtMaxAggregate").attr("readonly", true);
          $("#txtMaxAggregate").removeClass("input-disabled").addClass("input-disabled");
          $("#txtMaxAggregate").removeAttr("required");
          $("#txtMaxAggregate").val("");
          $('label[for="txtMaxAggregate"]').addClass("redasterisk").removeClass("redasterisk");
          $("#txt415a6_AggregateOffering").attr("readonly", true);
          $("#txt415a6_AggregateOffering").removeClass("input-disabled").addClass("input-disabled");
          $("#txt415a6_AggregateOffering").removeAttr("required");
          $("#txt415a6_AggregateOffering").val("");
          $('label[for="txt415a6_AggregateOffering"]').removeClass("redasterisk");
        }
      }
      //show/hide container when 415(a)(6) is checked
      if (id.indexOf("415a6") > -1) {
        clearFormElements("#container415a6");
        if ($(this).is(":checked")) {
          $("#container415a6").css("display", "block");
          if ($("#rchoice457o").is(":checked") === false) {
            //remove gray box
            $("#txt415a6_UnsoldSharesCF").attr("readonly", false);
            $("#txt415a6_UnsoldSharesCF").removeClass("input-disabled");
            $('label[for="txt415a6_UnsoldSharesCF"]').addClass("redasterisk");
            //add gray box
            $("#txt415a6_AggregateOffering").attr("readonly", true);
            $("#txt415a6_AggregateOffering").removeClass("input-disabled").addClass("input-disabled");
            $("#txt415a6_AggregateOffering").val("");
            $('label[for="txt415a6_AggregateOffering"]').removeClass("redasterisk");
          } else {
            //add gray box
            $("#txt415a6_UnsoldSharesCF").attr("readonly", true);
            $("#txt415a6_UnsoldSharesCF").removeClass("input-disabled").addClass("input-disabled");
            $("#txt415a6_UnsoldSharesCF").val("");
            $('label[for="txt415a6_UnsoldSharesCF"]').removeClass("redasterisk");
            //remove gray box
            $("#txt415a6_AggregateOffering").attr("readonly", false);
            $("#txt415a6_AggregateOffering").removeClass("input-disabled");
            $('label[for="txt415a6_AggregateOffering"]').addClass("redasterisk");
          }
        } else {
          $("#container415a6").css("display", "none");
        }
      }
      //show/hide container when 429 is checked
      if (id.indexOf("429") > -1) {
        clearFormElements("#container429");
        if ($(this).is(":checked")) {
          $("#container429").css("display", "block");
        } else {
          $("#container429").css("display", "none");
        }
      }
      //show/hide container when 457(p) is checked
      if (id.indexOf("457p") > -1) {
        clearFormElements("#container457p")
        if ($(this).is(":checked")) {
          $("#container457p").css("display", "block");
        } else {
          $("#container457p").css("display", "none");
        }
      }
      //show/hide certain elements
      if (id.indexOf("457c") > -1) {
        var pricePerShareLabel = $("#txtSharePrice").closest("div").prev();
        if ($(this).is(":checked")) {
          $("#rchoice457o").attr("disabled", "disabled");
          $("#rchoice457a").attr("disabled", "disabled");
          clearFormElements("#containerLowHighShare")
          //show/hide average word when 457(c) is checked
          //457(p) focus append "avergage" to price per share
          pricePerShareLabel.text(pricePerShareLabel.text().replace("Maximum", "Average"));
          $("label[for='txtSharePrice']").removeClass("redasterisk");
          //show/hide low/high price per share
          $("#txtSharePrice").attr("readonly", true);
          $("#txtSharePrice").addClass("input-disabled");
          $("#containerLowHighShare").css("display", "block");
        } else {
          $("#rchoice457o").attr("disabled", false);
          $("#rchoice457a").attr("disabled", false);
          //457(p) focus remove "avergage" to price per share
          pricePerShareLabel.text(pricePerShareLabel.text().replace("Average", "Maximum"));
          $("label[for='txtSharePrice']").addClass("redasterisk");
          $("#txtSharePrice").attr("readonly", false);
          $("#txtSharePrice").removeClass("input-disabled");
          $("#containerLowHighShare").css("display", "none");
        }
      }
      if (id.indexOf("457a") > -1) {
        if ($(this).is(":checked")) {
          $("#rchoice457o").attr("disabled", "disabled");
          $("#rchoice457c").attr("disabled", "disabled");
        } else {
          $("#rchoice457o").attr("disabled", false);
          $("#rchoice457c").attr("disabled", false);
        }
      }
    });
    //focus out on price per share; if low/high populated and don't calculate to price/share then remove low/high
    $("#txtSharePrice").focusout(function() {
      var priceShare = stripCurrency($(this).val());
      var lowPriceShare = $("#txtLowSharePrice").val() === "" ? 0 : stripCurrency($("#txtLowSharePrice").val());
      var highPriceShare = $("#txtHighSharePrice").val() === "" ? 0 : stripCurrency($("#txtHighSharePrice").val());
      if ((Number(lowPriceShare) + Number(highPriceShare)) / 2 !== Number(priceShare)) {

        $("#txtLowSharePrice").val("");
        $("#txtHighSharePrice").val("");
      }
    });
    //focusout on low/high price per share; if populated then do calculation and put result in price/share
    $("input[type='text']").focusout(function() {
      var id = $(this).attr("id").toUpperCase();
      //only go in if we have an id
      if (typeof id !== "undefined") {
        //focusout is either low or high price/share
        if (id.indexOf("LOW") > 0 || id.indexOf("HIGH") > 0) {
          //force "" to be a character so it's identified as not a number (NaN)
          var lowPriceShare = $("#txtLowSharePrice").val() === "" ? "a" : stripCurrency($("#txtLowSharePrice").val());
          var highPriceShare = $("#txtHighSharePrice").val() === "" ? "a" : stripCurrency($("#txtHighSharePrice").val());
          //if both low and high are numbers then do the multiplication and put value in price/share
          if (!isNaN(lowPriceShare) && !isNaN(highPriceShare)) {
            var price = (Number(lowPriceShare) + Number(highPriceShare)) / 2;
            $('#txtSharePrice').autoNumeric("set", price);
          }
        }
        //focus out is either amount to be registered or price/share or low/high price/share
        if (id.indexOf("SHAREPRICE") > 0 || id.indexOf("REGAMOUNT") > 0 || id.indexOf("LOW") > 0 || id.indexOf("HIGH") > 0) {
          var priceShare = stripCurrency($("#txtSharePrice").val());
          //force "" to be a character so it's identified as not a number (NaN)
          var regAmount = $("#txtRegAmount").val() === "" ? "a" : stripCurrency($("#txtRegAmount").val());

          //if both amount to be registered and price/share are numbers then do multiplication and put value in max agg offering
          if (!isNaN(priceShare) && !isNaN(regAmount)) {
            $("#txtMaxAggregate").autoNumeric("set", priceShare * regAmount);
          }
        }
      }
    });
    //click on either date or question mark
    //if date icon is clicked then put focus into date textbox so jquery datepicker pops up
    //if question mark then trigger hidden button click on net fee modal
    $("i").click(function() {
      if ($(this).attr("class").indexOf("calendar") > -1) {
        var id = $(this).closest("div").prev("div").find("input[type='text']").attr("id");
        $("#" + id).focus();

      } else if ($(this).attr("class").indexOf("question") > -1) {
        $("#hiddenDialogNetFeeButton").click();
      }
    });
    //button click on main page (either clear entries or calculate fees)
    $("a").click(function() {
      var txt = $(this).text().toUpperCase();
      //clear button
      if (txt.indexOf("CLEAR") > -1) {
        //input boxes
        $("input[type='text']").each(function(index, el) {
          $(this).val("");
        });
        //check boxes
        $("input[type='checkbox'").each(function(index, el) {
          //trigger change to clear 429 average price if needed
          $(this).prop("checked", false).change();
        });
        //select
        //remove
        $("option[selected='selected']").each(function() {
          $(this).removeAttr('selected');
        });
        //make first one selected
        $("select").each(function(index, el) {
          $(this).find("option:first").attr("selected", "selected");

        });
        //hide containers that were initially hidden
        $("div").each(function(index, el) {
          var id = $(this).attr("id");

          if (typeof id != "undefined") {
            if (id.indexOf("container") > -1) {

              $(this).css("display", "none");
            }
          }
        });
        //Reset required asterisk
        validationCheck();
      }
      //calculate button
      else if (txt.indexOf("CALCULATE") > -1) {
        //first perform validation check
        var rtnErrorObj = validationCheck();
        var errors = rtnErrorObj.Errors;
        var gaErrors = rtnErrorObj.ErrorsGAFormat;
        //if errors then show error red bock
        if (errors.length > 0) {
          $("#containerError div:last").html(errors);
          $("#containerError").css("display", "block", "border-width:0");
          $("#containerError").attr("aria-live", "assertive");
          $("#containerError").attr("role", "alert");
          //send data to google analytics
          ga('send', {
            hitType: 'event',
            eventCategory: 'error',
            eventAction: 'calculate button click',
            eventLabel: gaErrors
          });

        }
        //no errors
        else {
          //clear errors if needed
          $("#containerError").css("display", "none");
          //perform calculation logic and take to confirm modal
          calculationLogic();
          //send data to google analytics
          ga('send', {
            hitType: 'event',
            eventCategory: 'successful validation',
            eventAction: 'calculate button click',
            eventLabel: JSON.stringify(gMasterCalculation)
          });

        }
      }
    });
    /**
     * Calculates fee rate
     * @param {Date/String} inDate (optional)
     * @return {Number} fee rate
     */
    function getFeeRate(inDate) {
      var sysdate = new Date();
      //no input parm or future date, then use current date
      if (!inDate) {
        sysdate = new Date();
      }
      //cast input parm to date if string
      else {
        sysdate = objectToDate(inDate);
      }
      //don't want to compare on times
      sysdate.setHours(0, 0, 0, 0);
      if (sysdate > gFeeRate[gFeeRate.length - 1].endDate) {
        return gFeeRate[gFeeRate.length - 1].rate;
      }
      //find appropriate fee rate and return it
      for (var i = 0; i < gFeeRate.length; i++) {
        if (sysdate >= gFeeRate[i].startDate && sysdate <= gFeeRate[i].endDate) {
          return gFeeRate[i].rate;
        }
      }
      //return 0 if can't find fee rate based on date
      return 0;
    }
    /**
     * Casts object to date
     * @param {Date/String} inDate
     * @return {Date} date
     */
    function objectToDate(inDate) {
      //if passed in a date then just return that date
      if ((inDate instanceof Date) === true) {
        return inDate;
      }
      //not a date that was passed in
      else {
        var rtnDate;
        //attempt to cast string to date
        try {

          rtnDate = new Date(inDate);
        }
        //if we can't cast it then just return 1/1/1970
        catch (err) {
          return new Date(1970, 1, 1);
        }
        return rtnDate;
      }
    }
    /**
     * Checks if input parm is in correct format, returns boolean
     * @param {String} inp
     * @param {String} type (Date, Number, Form Type, or File Number)
     * @return {Boolean} rtnStatus
     */
    function inputCheck(inp, type) {
      var rtnStatus = true;
      var patt = "";
      //make sure we are passing in a string; if not, then make it a blank string
      if (!(typeof inp === 'string')) {
        inp = "";
      }
      if (type === "Date") {
        //needs to be in format mm/dd/yyyy
        patt = /\d{1,2}\/\d{1,2}\/\d{4}/;
        rtnStatus = patt.test(inp);
      } else if (type === "Number") {
        //needs to be digits maybe a . then more digits
        inp = stripCurrency(inp);
        patt = /^(\d+)(\.\d+)?$/;
        rtnStatus = patt.test(inp);
      } else if (type === "Form Type") {
        //needs to match any word, /, -, and space
        patt = /[a-zA-Z0-9-\/\s]+/;
        //check each character
        var chars = inp.split('');
        var test = false;
        for (var i = 0; i < chars.length; i++) {
          test = patt.test(chars[i]);
          if (test === false) {
            rtnStatus = false;
            break;
          }
        }
      } else if (type === "File Number") {
        //must match digits then - then more digits
        patt = /\d+-\d+/;
        rtnStatus = patt.test(inp);
      }
      return rtnStatus;
    }

    function clearObject(obj) {
      for (var k in obj) {
        //if an array then set it to "" and then call recursion
        if ($.isArray(obj[k])) {
          obj[k] = "";
          clearObject(obj[k]);
        }
        //if an object then call recursive call
        if (typeof obj[k] == "object" && obj[k] !== null) {

          clearObject(obj[k]);
        }
        //if a string then set it to "" and then call recursion
        else if (typeof obj[k] == "string" && obj[k] !== null) {
          //clear it out
          obj[k] = "";
          clearObject(obj[k]);
        }
      }
    }
    /**
     * Performs calculation logic when user hits calculate button; will take user to confirm modal and populate global mastercalculation object that is used for models and pdf
     * @param none
     * @return none
     */
    function calculationLogic() {
      if ($('.focusText').length > 0) { // remove highlighted text
        $('.focusText').removeClass('focusText');
      }
      //clear gMasterCalculation object out for fresh click
      clearObject(gMasterCalculation);
      //set a few fields to $0 in case they aren't used
      gMasterCalculation.netFeeModal._457a.amtCarriedForward = "0";
      gMasterCalculation.netFeeModal._457a.offset = "$0.00";
      gMasterCalculation.netFeeModal._457o.aggCarriedForward = "$0.00";
      gMasterCalculation.netFeeModal._457o.offset = "$0.00";
      //get fee rate for date selected
      var feeRate = getFeeRate($("#txtFilingDate").val());
      //set vars
      var maxAggOfferingPrice = 0;
      var regFee = 0;
      var amtDue = 0;
      //get rules checked and populate master object to store them
      var rulesArr = [];
      $("input[type='checkbox']").each(function() {
        if ($(this).is(':checked')) {
          rulesArr.push($(this).attr("id"));
        }
      });
      gMasterCalculation.rulesSelected = rulesArr;
      //fadeOutAllScreens();
      //457(a)
      if ($("#rchoice457o").is(":checked") === false) {
        //set net fee modal to a
        gMasterCalculation.netFeeModal.chosenOorA = "a";
        //MAX AGG OFFERING
        maxAggOfferingPrice = stripCurrency($("#txtRegAmount").val());
        //415(a)(6)
        if ($("#rchoice415a6").is(":checked") === true) {
          //amount carried forward for net fee modal
          gMasterCalculation.netFeeModal._457a.amtCarriedForward = stringToCurrency(Math.min(stripCurrency($("#txt415a6_UnsoldSharesCF").val()), maxAggOfferingPrice), "0", "NC");
          maxAggOfferingPrice -= stripCurrency(gMasterCalculation.netFeeModal._457a.amtCarriedForward);
        }
        //price per share for net fee modal
        gMasterCalculation.netFeeModal._457a.priceShare = $("#txtSharePrice").val();
        maxAggOfferingPrice *= stripCurrency($("#txtSharePrice").val());
        //REGISTRATION FEE
        regFee = maxAggOfferingPrice;
        regFee *= feeRate;
        //457(p)
        if ($("#rchoice457p").is(":checked") === true) {
          //net fee modal amount offset
          //set not to exceed regFee
          gMasterCalculation.netFeeModal._457a.offset = stringToCurrency(Math.min(stripCurrency($("#txt457p_AmountAvailableOffset").val()), regFee));
        }
        $("#feeestimatorform").fadeOut(100);
        $("#dataEntryTab").fadeIn(200);

      }
      //457(o)
      else if ($("#rchoice457o").is(":checked") === true) {
        //set net fee modal to o
        gMasterCalculation.netFeeModal.chosenOorA = "o";
        //MAX AGG OFFERING
        maxAggOfferingPrice = stripCurrency($("#txtMaxAggregate").val());
        //REGISTRATION FEE
        regFee = maxAggOfferingPrice;
        //415(a)(6)
        if ($("#rchoice415a6").is(":checked") === true) {
          //amount carried forward net fee modal
          gMasterCalculation.netFeeModal._457o.aggCarriedForward = stringToCurrency(Math.min(stripCurrency($("#txt415a6_AggregateOffering").val()), regFee));
          regFee = stringToCurrency(regFee - stripCurrency(gMasterCalculation.netFeeModal._457o.aggCarriedForward));
        }
        regFee = stringToCurrency(stripCurrency(regFee) * feeRate);
        //457(p)
        if ($("#rchoice457p").is(":checked") === true) {
          //net fee modal amount offset
          //set not to exceed regFee
          gMasterCalculation.netFeeModal._457o.offset = stringToCurrency(Math.min(stripCurrency($("#txt457p_AmountAvailableOffset").val()), stripCurrency(regFee)));
        }
        $("#feeestimatorform").fadeOut(100);
        $("#dataEntryTab").fadeIn(200);
      }
      //429
      //show note for hover text on net fee modal
      if ($("#rchoice429").is(":checked") === true) {
        gMasterCalculation.netFeeModal._457o._429Note = "Show";
        gMasterCalculation.netFeeModal._457a._429Note = "Show";
        $("#feeestimatorform").fadeOut(100);
        $("#dataEntryTab").fadeIn(200);
      } else {
        gMasterCalculation.netFeeModal._457o._429Note = "";
        gMasterCalculation.netFeeModal._457a._429Note = "";
      }
      //NET FEE MODAL
      //457a
      gMasterCalculation.netFeeModal._457a.securityTitle = $("#txtSecurityTitle").val();
      if ($("#txtRegAmount").val() === "") {
        gMasterCalculation.netFeeModal._457a.amtRegistered = "-";
      } else {
        gMasterCalculation.netFeeModal._457a.amtRegistered = $("#txtRegAmount").val();
      }
      gMasterCalculation.netFeeModal._457a.adjAmt = stringToCurrency(stripCurrency(gMasterCalculation.netFeeModal._457a.amtRegistered) - stripCurrency(gMasterCalculation.netFeeModal._457a.amtCarriedForward), "0", "NC");
      if (!isNaN(stripCurrency(gMasterCalculation.netFeeModal._457a.adjAmt))) {
        gMasterCalculation.netFeeModal._457a.maxAggOffering = stringToCurrency(stripCurrency(gMasterCalculation.netFeeModal._457a.adjAmt) * stripCurrency(gMasterCalculation.netFeeModal._457a.priceShare));
      } else {
        gMasterCalculation.netFeeModal._457a.maxAggOffering = stringToCurrency($("#txtMaxAggregate").val());
      }
      gMasterCalculation.netFeeModal._457a.subAggregate = gMasterCalculation.netFeeModal._457a.maxAggOffering;
      gMasterCalculation.netFeeModal._457a.totAggregate = gMasterCalculation.netFeeModal._457a.maxAggOffering;
      gMasterCalculation.netFeeModal._457a.feeRate = feeRate;
      gMasterCalculation.netFeeModal._457a.regFee = stringToCurrency(regFee);
      gMasterCalculation.netFeeModal._457a.netFee = stringToCurrency(stripCurrency(gMasterCalculation.netFeeModal._457a.regFee) - stripCurrency(gMasterCalculation.netFeeModal._457a.offset));
      //457o
      gMasterCalculation.netFeeModal._457o.securityTitle = gMasterCalculation.netFeeModal._457a.securityTitle;
      gMasterCalculation.netFeeModal._457o.aggregate = stringToCurrency($("#txtMaxAggregate").val());
      gMasterCalculation.netFeeModal._457o.adjGrossAggregate = stringToCurrency(stripCurrency(gMasterCalculation.netFeeModal._457o.aggregate) - stripCurrency(gMasterCalculation.netFeeModal._457o.aggCarriedForward));
      gMasterCalculation.netFeeModal._457o.subAggregate = gMasterCalculation.netFeeModal._457o.adjGrossAggregate;
      gMasterCalculation.netFeeModal._457o.totAggregate = gMasterCalculation.netFeeModal._457o.adjGrossAggregate;
      gMasterCalculation.netFeeModal._457o.feeRate = feeRate;
      gMasterCalculation.netFeeModal._457o.regFee = gMasterCalculation.netFeeModal._457a.regFee;;
      gMasterCalculation.netFeeModal._457o.netFee = stringToCurrency(stripCurrency(gMasterCalculation.netFeeModal._457o.regFee) - stripCurrency(gMasterCalculation.netFeeModal._457o.offset));
      populateNetFeeModal(gMasterCalculation.netFeeModal);
      var footNotesHolder = getFootNotesArr();
      //DATA ENTRY MODAL
      //Registration Fee
      gMasterCalculation.dataEntryModal.calcRegFee.securityTitle = gMasterCalculation.netFeeModal._457a.securityTitle;
      gMasterCalculation.dataEntryModal.calcRegFee.amtRegistered = gMasterCalculation.netFeeModal._457a.amtRegistered;
      gMasterCalculation.dataEntryModal.calcRegFee.proposedMaxOffering = stringToCurrency($("#txtSharePrice").val());
      gMasterCalculation.dataEntryModal.calcRegFee.proposedMaxAggOffering = stringToCurrency($("#txtMaxAggregate").val());
      gMasterCalculation.dataEntryModal.calcRegFee.amtRegFee = gMasterCalculation.netFeeModal._457a.regFee;
      gMasterCalculation.dataEntryModal.calcRegFee.romanNumeralHeadingAppend = footNotesHolder.arrRomanNumeralAppend;
      populateDataEntryModal(gMasterCalculation.dataEntryModal);
      //loop through titles and replace any (i), etc with ""
      $("#dataEntryCalRegFeeTable thead tr th").each(function() {
        var holder = $(this).html();
        holder = holder.replace(/\(.*\)/, "")
        $(this).html(holder);
      });
      //add romannumerals to title
      for (var i = 0; i < gMasterCalculation.dataEntryModal.calcRegFee.romanNumeralHeadingAppend.length; i++) {
        var elementAt = i + 3;
        var holder = $("#dataEntryCalRegFeeTable thead tr th:nth-of-type(" + elementAt + ")");
        var holder2 = holder.text();
        //replace any previous (i), etc we have in there
        holder.text(holder2 + " " + gMasterCalculation.dataEntryModal.calcRegFee.romanNumeralHeadingAppend[i]);
      }
      gMasterCalculation.dataEntryModal.calcRegFee.dataFields = getTableHeadingsPopulated("Registration Fee");
      //Filing Foototes
      gMasterCalculation.dataEntryModal.footNotes.filingFootnotes = footNotesHolder.arrFootnotes;
      gMasterCalculation.dataEntryModal.footNotes.dataFields = footNotesHolder.arrFootnotesDataFields;
      //EDGAR Header
      //offering and fees
      gMasterCalculation.dataEntryModal.edgarHeader.offAndFees.securityType = $("#ddlSecurityType option:selected").text();
      gMasterCalculation.dataEntryModal.edgarHeader.offAndFees.amtRegistered = gMasterCalculation.netFeeModal._457a.amtRegistered
      gMasterCalculation.dataEntryModal.edgarHeader.offAndFees.proposedMaxOffering = gMasterCalculation.dataEntryModal.calcRegFee.proposedMaxOffering;
      if ($("#rchoice415a6").is(":checked") === false) {
        gMasterCalculation.dataEntryModal.edgarHeader.offAndFees.amtRegistered = gMasterCalculation.netFeeModal._457a.amtRegistered;
        gMasterCalculation.dataEntryModal.edgarHeader.offAndFees.proposedMaxAggOffering = gMasterCalculation.dataEntryModal.calcRegFee.proposedMaxAggOffering;
      } else if ($("#rchoice415a6").is(":checked") === true && $("#rchoice457o").is(":checked") === false) {
        gMasterCalculation.dataEntryModal.edgarHeader.offAndFees.amtRegistered = stringToCurrency((stripCurrency($("#txtRegAmount").val()) - stripCurrency($("#txt415a6_UnsoldSharesCF").val())), "0", "NC");
        gMasterCalculation.dataEntryModal.edgarHeader.offAndFees.proposedMaxAggOffering =
          stringToCurrency((stripCurrency($("#txtRegAmount").val()) - stripCurrency($("#txt415a6_UnsoldSharesCF").val())) * stripCurrency($("#txtSharePrice").val()))
      } else if ($("#rchoice415a6").is(":checked") === true && $("#rchoice457o").is(":checked") === true) {
        gMasterCalculation.dataEntryModal.edgarHeader.offAndFees.amtRegistered = gMasterCalculation.netFeeModal._457a.amtRegistered;
        gMasterCalculation.dataEntryModal.edgarHeader.offAndFees.proposedMaxAggOffering =
          stringToCurrency(stripCurrency($("#txtMaxAggregate").val()) - stripCurrency($("#txt415a6_AggregateOffering").val()));
      }
      populateDataEntryModal(gMasterCalculation.dataEntryModal);
      gMasterCalculation.dataEntryModal.edgarHeader.offAndFees.dataFields = getTableHeadingsPopulated("Offering and Fees");
      populateDataEntryModal(gMasterCalculation.dataEntryModal);
      //fee and offset
      gMasterCalculation.dataEntryModal.edgarHeader.feeAndOffset.cik = $("#txt457p_CIK").val();
      gMasterCalculation.dataEntryModal.edgarHeader.feeAndOffset.formType = $("#txt457p_FormType").val();
      gMasterCalculation.dataEntryModal.edgarHeader.feeAndOffset.fileNumber = $("#txt457p_FileNumber").val();
      gMasterCalculation.dataEntryModal.edgarHeader.feeAndOffset.offsetFilingDate = $("#txt457p_FilingDate").val();
      //set not to exceed regFee
      gMasterCalculation.dataEntryModal.edgarHeader.feeAndOffset.amt = stringToCurrency(Math.min(stripCurrency($("#txt457p_AmountAvailableOffset").val()), stripCurrency(regFee)));
      populateDataEntryModal(gMasterCalculation.dataEntryModal);
      gMasterCalculation.dataEntryModal.edgarHeader.feeAndOffset.dataFields = getTableHeadingsPopulated("Fee and Offset");
      populateDataEntryModal(gMasterCalculation.dataEntryModal);
      //setting up tooltips
      $('span[tooltip="DataFieldsInOutput"]').tooltip();
      $(".clickableDataField").on("click", function() {
        var id = $(this).attr("for");
        if ($(".focusText").length > 0) {
          var isDifferentElClicked = $(".focusText").attr("id") != id;
          $(".focusText").removeClass("focusText");
          if (isDifferentElClicked) {
            $("#" + id).addClass("focusText");
          }
        } else {
          $("#" + id).addClass("focusText");
        }
      });
    }
    /**
     * Populates dom for net fee modal
     * @param none
     * @return none
     */
    function populateNetFeeModal(inp) {
      //457a
      if ($("#rchoice457o").is(":checked") === false) {
        inp = inp._457a;
        //429 link
        if (!(inp._429Note === "")) {
          $("#netFeeTableTab > div:nth-child(3) > div > div:nth-child(3) a").show();
          $("#netFeeTableTab > div:nth-child(4) > div:nth-child(1) > p").html(gHelpText["NetFeeModal429Hover"]); //.css({"font-size": "80%"});;
        } else {
          $("#netFeeTableTab > div:nth-child(3) > div > div:nth-child(3) a").hide();
          $("#netFeeTableTab > div:nth-child(4) > div:nth-child(1) > p").html("");
        }
        $("#netFeeTableTab > div:nth-child(2) p").html("The Registration Fee for the following securities is based on the Amount to be Registered:");
        //security title
        $(".NetFeeBreakdown tbody tr:nth-child(1) td:nth-child(1)").text(inp.securityTitle);
        //amount to be registered
        $(".NetFeeBreakdown tbody tr:nth-child(1) td:nth-child(2)").text(inp.amtRegistered);
        //amount carried forward
        $(".NetFeeBreakdown tbody tr:nth-child(1) td:nth-child(3)").text(inp.amtCarriedForward);
        //adjusted amount (less carry forward)
        $(".NetFeeBreakdown tbody tr:nth-child(1) td:nth-child(4)").text(inp.adjAmt);
        //price per share
        $(".NetFeeBreakdown tbody tr:nth-child(1) td:nth-child(5)").text(inp.priceShare);
        //max agg offering price
        $(".NetFeeBreakdown tbody tr:nth-child(1) td:nth-child(6)").text(inp.maxAggOffering);
        //aggregate
        $(".NetFeeBreakdown tbody tr:nth-child(2) td:nth-child(2)").text(inp.subAggregate);
        //total aggregate
        $(".NetFeeCalculation tbody tr:nth-child(1) td:nth-child(2)").text(inp.totAggregate);
        //fee rate
        $(".NetFeeCalculation tbody tr:nth-child(2) td:nth-child(3)").text(inp.feeRate);
        //registration fee
        $(".NetFeeCalculation tbody tr:nth-child(3) td:nth-child(2)").text(inp.regFee);
        //offset
        $(".NetFeeCalculation tbody tr:nth-child(4) td:nth-child(3)").text(inp.offset);
        //net fee
        $(".NetFeeCalculation tbody tr:nth-child(5) td:nth-child(2)").text(inp.netFee);
      }
      //457o
      else {
        inp = inp._457o;
        //429 link
        if (!(inp._429Note === "")) {
          $("#netFeeTableTab > div:nth-child(3) > div > div:nth-child(3) a").show();
          $("#netFeeTableTab > div:nth-child(4) > div:nth-child(1) > p").html(gHelpText["NetFeeModal429Hover"]); //.css({"font-size": "80%"});
        } else {
          $("#netFeeTableTab > div:nth-child(3) > div > div:nth-child(3) a").hide();
          $("#netFeeTableTab > div:nth-child(4) > div:nth-child(1) > p").html("");
        }
        $("#netFeeTableTab > div:nth-child(2) p").html("The Registration Fee for the following securities is based on the Maximum Aggregate Offering Price:");
        //security title
        $(".NetFeeBreakdown tbody tr:nth-child(1) td:nth-child(1)").text(inp.securityTitle);
        //aggregate
        $(".NetFeeBreakdown tbody tr:nth-child(1) td:nth-child(2)").text(inp.aggregate);
        //aggregate carried forward
        $(".NetFeeBreakdown tbody tr:nth-child(1) td:nth-child(3)").text(inp.aggCarriedForward);
        //adjusted gross aggregate (less carry forward)
        $(".NetFeeBreakdown tbody tr:nth-child(1) td:nth-child(4)").text(inp.adjGrossAggregate);
        //aggregate
        $(".NetFeeBreakdown tbody tr:nth-child(2) td:nth-child(2)").text(inp.subAggregate);
        //total aggregate
        $(".NetFeeCalculation tbody tr:nth-child(1) td:nth-child(2)").text(inp.totAggregate);
        //fee rate
        $(".NetFeeCalculation tbody tr:nth-child(2) td:nth-child(3)").text(inp.feeRate);
        //registration fee
        $(".NetFeeCalculation tbody tr:nth-child(3) td:nth-child(2)").text(inp.regFee);
        //offset
        $(".NetFeeCalculation tbody tr:nth-child(4) td:nth-child(3)").text(inp.offset);
        //net fee
        $(".NetFeeCalculation tbody tr:nth-child(5) td:nth-child(2)").text(inp.netFee);
      }
    }
    /**
     * Populates dom for data entry modal
     * @param none
     * @return none
     */
    function populateDataEntryModal(inp) {
      //REGISTRATION FEE TABLE
      //applicable data fields
      $("#dataEntCalRegFeeTabApplDataFieldsUL").html(arrayAppendHTMLTag(inp.calcRegFee.dataFields, "li"));
      //table
      //row
      //title
      $("#dataEntryCalRegFeeTable tbody tr td:nth-child(1)").html(inp.calcRegFee.securityTitle)
      //amount to be registerd
      $("#dataEntryCalRegFeeTable tbody tr td:nth-child(2)").text(inp.calcRegFee.amtRegistered);
      //proposed max offering price per unit
      $("#dataEntryCalRegFeeTable tbody tr td:nth-child(3)").text(inp.calcRegFee.proposedMaxOffering);
      //proposed max agg offering price
      $("#dataEntryCalRegFeeTable tbody tr td:nth-child(4)").text(inp.calcRegFee.proposedMaxAggOffering);
      //amount of reg fee
      $("#dataEntryCalRegFeeTable tbody tr td:nth-child(5)").text(inp.calcRegFee.amtRegFee);
      //FOOTNOTES
      //applicable data fields
      if (inp.footNotes.dataFields == "" || inp.footNotes.dataFields == null || typeof(inp.footNotes.dataFields) == "undefined") {
        inp.footNotes.dataFields = ["None"];
      }
      $(".dataEntryFilFootApplDataFieldsUL").html(arrayAppendHTMLTag(inp.footNotes.dataFields, "li"));
      //footnotes
      if ($.isArray(inp.footNotes.filingFootnotes)) {
        $(".dataEntryFilFootSampleP").html(inp.footNotes.filingFootnotes.join("<br><br>"));
      }
      //EDGAR HEADER
      //offering and fees
      //applicable data fields
      $("#dataEntryEdgarApplDataFieldsUL").html(arrayAppendHTMLTag(inp.edgarHeader.offAndFees.dataFields, "li"));
      //table
      $("#dataEntryEdgarOfferingnFeesTable tbody tr td:nth-child(1)").text(inp.edgarHeader.offAndFees.securityType);
      $("#dataEntryEdgarOfferingnFeesTable tbody tr td:nth-child(2)").text(inp.edgarHeader.offAndFees.amtRegistered);
      $("#dataEntryEdgarOfferingnFeesTable tbody tr td:nth-child(3)").text(inp.edgarHeader.offAndFees.proposedMaxOffering);
      $("#dataEntryEdgarOfferingnFeesTable tbody tr td:nth-child(4)").text(inp.edgarHeader.offAndFees.proposedMaxAggOffering);
      //fee and offset (only show if 457p is checked)
      if ($("#rchoice457p").is(":checked") === true) {
        $(".dataEntryEdgaroffSetInfo").css("display", "");
        //applicable data fields
        $("ul.dataEntryEdgaroffSetInfo").html(arrayAppendHTMLTag(inp.edgarHeader.feeAndOffset.dataFields, "li"));
        //table
        $("table.dataEntryEdgaroffSetInfo tbody tr td:nth-child(1)").text(inp.edgarHeader.feeAndOffset.cik);
        $("table.dataEntryEdgaroffSetInfo tbody tr td:nth-child(2)").text(inp.edgarHeader.feeAndOffset.formType);
        $("table.dataEntryEdgaroffSetInfo tbody tr td:nth-child(3)").text(inp.edgarHeader.feeAndOffset.fileNumber);
        $("table.dataEntryEdgaroffSetInfo tbody tr td:nth-child(4)").text(inp.edgarHeader.feeAndOffset.offsetFilingDate);
        $("table.dataEntryEdgaroffSetInfo tbody tr td:nth-child(5)").text(inp.edgarHeader.feeAndOffset.amt);
      }
      //don't show if 457(p) is not checked
      else {
        $(".dataEntryEdgaroffSetInfo").css("display", "none");
      }
    }
    /**
     * Loops through table heading and td and determines which table heading has a corresponsding populated td (not blank or non "-"). Returns an array of only those table headings.
     * @param {String} inp
     * @return {array String} arr
     */
    function getTableHeadingsPopulated(typ) {
      var arr = [];
      var arrRemove = [];
      var idx = 0;
      var elementID = 1;
      if (typ === "Offering and Fees") {
        //determine header fields in edgar header table on data entry modal and put in array
        $("#dataEntryEdgarOfferingnFeesTable thead tr th").each(function() {
          var holder = stripHTMLTags($(this).html());
          holder = '<span class="clickableDataField" for="spanOfferingFees' + elementID + '">' + holder + '</span>';
          arr.push(holder);
          elementID++;
        });
        elementID = 1;
        //remove it from array if it's not populated
        $("#dataEntryEdgarOfferingnFeesTable tbody tr td").each(function() {
          //delete first
          if (idx === 0) {
            // arrRemove.push(idx);
          } else if (stripHTMLTags($(this).html()) === "-") {
            arrRemove.push(idx);
          }
          thisID = "spanOfferingFees" + elementID;
          $(this).attr("id", thisID);
          idx++;
          elementID++;
        });
      } else if (typ === "Fee and Offset") {
        //determine header fields in edgar header table on data entry modal and put in array
        $("table.dataEntryEdgaroffSetInfo thead tr th").each(function() {
          var holder = stripHTMLTags($(this).html());
          holder = '<span class="clickableDataField" for="spanFeeOffset' + elementID + '">' + holder + '</span>';
          arr.push(holder);
          elementID++;
        });
        elementID = 1;
        //remove it from array if it's not populated
        $("table.dataEntryEdgaroffSetInfo tbody tr td").each(function() {
          //delete first
          if (idx === 0) {
            // arrRemove.push(idx);
          } else if (stripHTMLTags($(this).html()) === "-") {
            arrRemove.push(idx);
          }
          thisID = "spanFeeOffset" + elementID;
          $(this).attr("id", thisID);
          idx++;
          elementID++;
        });
      } else if (typ === "Registration Fee") {
        $("#dataEntryCalRegFeeTable thead tr th").each(function() {
          var holder = stripHTMLTags($(this).html());
          holder = '<span class="clickableDataField" for="spanCalRegFee' + elementID + '">' + holder + '</span>';
          arr.push(holder);
          elementID++;
        });
        //remove it from array if it's not populated
        elementID = 1;
        $("#dataEntryCalRegFeeTable tbody tr td").each(function() {
          if (stripHTMLTags($(this).html()) === "-") {
            arrRemove.push(idx);
          }
          thisID = "spanCalRegFee" + elementID;
          $(this).attr("id", thisID);
          idx++;
          elementID++;
        });
      }
      //sort array descending so deletes work from top to bottom
      arrRemove.sort(function(a, b) {
        return b - a
      });
      for (var i = 0; i < arrRemove.length; i++) {
        arr.splice(arrRemove[i], 1);
      }
      return arr;
    }
    /**
     * Based on an input array and html tag, will return a string of those html elements with the indicated tag. For example if ["test1", "test2"] and "li" was passed in
     * then it will return "<li>test1</li><li>test2</li>
     * @param {array String} inp
     * @param {String} tag
     * @return {String} output
     */
    function arrayAppendHTMLTag(inp, tag) {
      var output = "";
      tag = tag.replace("<", "").replace(">", "");
      tag = "<" + tag + ">";
      for (var i = 0; i < inp.length; i++) {
        output += tag + inp[i] + tag.substring(0, 1) + "/" + tag.substring(1);
      }
      return output;
    }
    /**
     * Calculates footnotes and footnote headings(i, ii, etc) from check boxes
     * @param none
     * @return {Object} footnote array, footnote headings, footnote datafields array
     */
    function getFootNotesArr() {
      var arrFootnotes = [];
      var arrFootnotesDataFields = [];
      //3 columns: max offering price per unit, max agg offering price, and amt of reg fee
      var arrRomanNumeralAppend = ["", "", ""];
      //457(c)
      if ($("#rchoice457c").is(":checked") === true) {
        if ($("#txtHighSharePrice").val() != "") {
          arrFootnotesDataFields.push("<span class=\"clickableDataField\" for=\"spantext_txtHighSharePrice\">" + $("label[for='txtHighSharePrice']").text() + "</span>");
          arrFootnotesDataFields.push("<span class=\"clickableDataField\" for=\"spantext_txtLowSharePrice\">" + $("label[for='txtLowSharePrice']").text() + "</span>");
        }
        var modHighSharePrice = $("#txtHighSharePrice").val();
        var modLowSharePrice = $("#txtLowSharePrice").val();
        if (modHighSharePrice != "") {
          modHighSharePrice = "( " + modHighSharePrice + " )";
        }
        if (modLowSharePrice != "") {
          modLowSharePrice = "( " + modLowSharePrice + " )";
        }
        arrFootnotesDataFields.push("Maximum Aggregate Offering Price");
        var isSaleValue = ($("#lblLowAskPriceText").text().toLowerCase() == "low") ? " sale" : "";
        arrFootnotes.push("Estimated in accordance with Rule 457(c) solely for purposes of calculating the registration fee. The maximum price per Security and the maximum aggregate offering price are based on the average of the " +
          "<span id=\"spantext_txtHighSharePrice\">" + $("#txtHighSharePrice").val() + "</span> (" + $("#lblHighBidPriceText").text().toLowerCase() + ") and <span id=\"spantext_txtLowSharePrice\">" + $("#txtLowSharePrice").val() + "</span> (" + $("#lblLowAskPriceText").text().toLowerCase() + ") " + isSaleValue + " price of the Registrant’s " +
          $("#txtSecurityTitle").val() + " as reported on the " + $("#txtMarketonWhichSalePriceRprtd").val() + " on " +
          $("#txtBidAskDtDate").val() + ", which date is within five business days prior to filing this Registration Statement.");
      } else {
        //457(a)
        if ($("#rchoice457o").is(":checked") === false) {
          arrFootnotes.push("Calculated pursuant to Rule 457(a) based on the Amount of Securities to be Registered multiplied by the Proposed Maximum Offering Price per Unit.");
        }
        //457(o)
        if ($("#rchoice457o").is(":checked") === true) {
          arrFootnotes.push("Calculated pursuant to Rule 457(o), based on the Proposed Maximum Aggregate Offering Price.");
        }
      }
      //415(a)(6)
      if ($("#rchoice415a6").is(":checked") === true) {
        //457(a)
        if ($("#rchoice457o").is(":checked") === false) {
          arrFootnotesDataFields.push("<span class=\"clickableDataField\" for=\"spantxt415a6_UnsoldSharesCF\">Number of Unsold Securities Carried Forward under Rule 415(a)(6)</span>");
          arrFootnotes.push("In accordance with Rule 415(a)(6) under the Securities Act of 1933, the securities registered pursuant to this registration statement include " +
            "<span id=\"spantxt415a6_UnsoldSharesCF\">" + $("#txt415a6_UnsoldSharesCF").val() + "</span> unsold securities that previously were registered pursuant to the registration statement on Form " +
            $("#txt415a6_FormType").val() + " (File No. " + $("#txt415a6_FileNumber").val() + ", initially effective on " +
            $("#txt415a6_EffectiveDate").val() + ". Pursuant to Rule 415(a)(6), the registration fees in the amount of " +
            $("#txt_FilingFeesPaidWUnsold415a6").val() + " previously paid with respect to such unsold securities will continue to be applied to such unsold securities.");
        }
        //457(o)
        if ($("#rchoice457o").is(":checked") === true) {
          arrFootnotesDataFields.push("<span class=\"clickableDataField\" for=\"spantxt415a6_AggregateOffering\">Aggregate Offering Amount of Unsold Securities Carried Forward under Rule 415(a)(6)</span>");
          arrFootnotes.push("In accordance with Rule 415(a)(6) under the Securities Act of 1933, the securities registered pursuant to this registration statement include " +
            "unsold securities in the amount of " +
            "<span id=\"spantxt415a6_AggregateOffering\">" + $("#txt415a6_AggregateOffering").val() + "</span> that previously were registered pursuant to the registration statement on Form " +
            $("#txt415a6_FormType").val() + " (File No. " + $("#txt415a6_FileNumber").val() + "), initially effective on " +
            $("#txt415a6_EffectiveDate").val() + ". Pursuant to Rule 415(a)(6), the registration fees in the amount of " +
            $("#txt_FilingFeesPaidWUnsold415a6").val() + " previously paid with respect to such unsold securities will continue to be applied to such unsold securities.");
        }
      }
      //457(p)
      if ($("#rchoice457p").is(":checked") === true) {
        var rep_regFee;
        if (gMasterCalculation.netFeeModal.chosenOorA === "o") {
          rep_regFee = gMasterCalculation.netFeeModal._457o.regFee;
        } else if (gMasterCalculation.netFeeModal.chosenOorA === "a") {
          rep_regFee = gMasterCalculation.netFeeModal._457a.regFee;
        };
        rep_regFee = Math.min(stripCurrency(rep_regFee), stripCurrency($("#txt457p_AmountAvailableOffset").val()));
        arrFootnotesDataFields.push("<span class=\"clickableDataField\" for=\"spantxt457p_AmountAvailableOffset\">Offset Amount</span>");
        arrFootnotesDataFields.push("<span class=\"clickableDataField\" for=\"spantxt457p_UnsoldMaxAggregate\">Maximum Aggregate Offering Amount of unsold securities from prior registration statement associated with claimed fee offset amount</span>");
        arrFootnotesDataFields.push("<span class=\"clickableDataField\" for=\"spantxt457p_FilingDate\">Filing Date of Filing being relied upon for Rule 457(p)</span>");
        arrFootnotesDataFields.push("<span class=\"clickableDataField\" for=\"spantxt457p_FileNumber\">File Number of registration statement from which a fee offset is claimed under Rule 457(p)</span>");
        var _dif_Amount_1 = stringToCurrency(parseFloat($("#txt457p_AmountAvailableOffset").val()) - parseFloat(gMasterCalculation.netFeeModal._457a.regFee.replace("$", "").replace(/,/g, "")));
        var _dif_Amount_2 = stringToCurrency(parseFloat(stripCurrency($("#txt457p_UnsoldMaxAggregate").val()) * getFeeRate($("#txt457p_FilingDate").val())).toFixed(2) - parseFloat($("#txt457p_AmountAvailableOffset").val()).toFixed(2));
        var _dif_Amount;
        if (_dif_Amount = _dif_Amount_1 > "$0.00" ? _dif_Amount_1 : _dif_Amount_2 > "$0.00" ? _dif_Amount_2 : 0) {
          arrFootnotes.push("Pursuant to Rule 457(p) under the Securities Act, the registrant is offsetting the registration fee due under this registration statement by " +
            "<span id=\"spantxt457p_AmountAvailableOffset\">" + stringToCurrency(rep_regFee) + "</span> with " + _dif_Amount + " remaining to be applied to future filings, which represents the portion of the registration fee previously paid with respect to " +
            "<span id=\"spantxt457p_UnsoldMaxAggregate\">" + stringToCurrency($("#txt457p_UnsoldMaxAggregate").val()) + "</span> of unsold securities previously registered on the registration statement on Form " +
            $("#txt457p_FormType").val() + " (File No. <span id=\"spantxt457p_FileNumber\">" + $("#txt457p_FileNumber").val() + "</span>), initially filed on " +
            "<span id=\"spantxt457p_FilingDate\">" + $("#txt457p_FilingDate").val() + "</span>");
        } else {
          arrFootnotes.push("Pursuant to Rule 457(p) under the Securities Act, the registrant is offsetting the registration fee due under this registration statement by " +
            "<span id=\"spantxt457p_AmountAvailableOffset\">" + stringToCurrency($("#txt457p_AmountAvailableOffset").val()) + "</span>, which represents the portion of the registration fee previously paid with respect to " +
            "<span id=\"spantxt457p_UnsoldMaxAggregate\">" + stringToCurrency($("#txt457p_UnsoldMaxAggregate").val()) + "</span> of unsold securities previously registered on the registration statement on Form " +
            $("#txt457p_FormType").val() + " (File No. <span id=\"spantxt457p_FileNumber\">" + $("#txt457p_FileNumber").val() + "</span>), initially filed on " +
            "<span id=\"spantxt457p_FilingDate\">" + $("#txt457p_FilingDate").val() + "</span>");
        }
      }
      //429
      if ($("#rchoice429").is(":checked") === true) {
        arrFootnotesDataFields.push("<span class=\"clickableDataField\" for=\"spantxt429_FileNumberPrior\">File Number of prior registration statement to which the combined prospectus relates</span>");
        arrFootnotesDataFields.push("<span class=\"clickableDataField\" for=\"spantxt429_PriorRegFilingFormType\">Form Type of prior registration statement to which the combined prospectus relates</span>");
        arrFootnotesDataFields.push("Maximum Aggregate Offering Price");
        arrFootnotes.push("In reliance on Rule 429 under the Securities Act of 1933,this registration statement contains a combined prospectus  which also relates" +
          " to the registration statement on Form <span id=\"spantxt429_PriorRegFilingFormType\">" + $("#txt429_PriorRegFilingFormType").val() + "</span> (File No. <span id=\"spantxt429_FileNumberPrior\">" + $("#txt429_FileNumberPrior").val() + "</span>)." +
          " Upon effectiveness, this registration statement will also act as a post-effective amendment to such earlier registration statement.");
      }
      var romanNumerals = ["i", "ii", "iii", "iv", "v", "vi", "vii", "viii", "ix", "x"];
      for (var i = 0; i < arrFootnotes.length; i++) {
        arrFootnotes[i] = romanNumerals[i] + ". " + arrFootnotes[i];
        //reg fee heading
        if (arrFootnotes[i].indexOf("457(p)") > 0) {
          arrRomanNumeralAppend[2] = "(" + romanNumerals[i] + ")";
        }
        //max offering price per unit
        else if (arrFootnotes[i].indexOf("457(c)") > 0) {
          arrRomanNumeralAppend[0] = "(" + romanNumerals[i] + ")";
        }
        //max agg offering price
        else {
          arrRomanNumeralAppend[1] += romanNumerals[i] + ", ";
        }
      }
      //strip max agg offering price roman numeral heading
      arrRomanNumeralAppend[1] = arrRomanNumeralAppend[1].trim();
      arrRomanNumeralAppend[1] = "(" + arrRomanNumeralAppend[1].substring(0, arrRomanNumeralAppend[1].length - 1) + ")";
      //return 3 arrays so put into object
      var objRtn = {
        arrFootnotes: arrFootnotes,
        arrRomanNumeralAppend: arrRomanNumeralAppend,
        arrFootnotesDataFields: arrFootnotesDataFields
      };
      return objRtn;
    }
    /**
     * Populates 3 global disclaimers on existing dom
     * @param none
     * @return none
     */
    function setDisclaimers() {
      //main page
      $("#divinfo").css("margin-left", "auto").css("margin-right", "auto").css("text-align", "centered").css("font-weight", "normal").css("line-height", "13px").css("color", "black").html(gInfo);
    }
    /**
     * Converts a string to currency
     * @param {Number} amt
     * @param String (optional)} prcn
     * @param {String (optional)} curr
     * @return {String}
     */
    function stringToCurrency(amt, prcn, curr) {
      var precision;
      var currency;
      //if currency is omitted then make it $
      if (!curr) {
        currency = "$";
      } else if (curr === "NC") {
        currency = "";
      } else {
        currency = curr;
      }
      //strip the amount of $ and .
      amt = stripCurrency(amt);
      //if amount is "" then return -
      if (amt === "") {
        return "-";
      }
      //if precision is omitted then default to 2
      if (!prcn) {
        precision = 2;
      } else if (prcn === "0") {
        var round = Math.round;
        amt = round(amt);
        return currency + amt.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");
      } else {
        precision = prcn;
      }
      //return currency indicator with rounded amt to (2 or precision) decimals
      return currency + parseFloat(amt).toFixed(precision).replace(/(\d)(?=(\d{3})+\.)/g, '$1,');
    }
    /**
     * verify year
     */
    function verifydate(indate) {
      var yearnumeric;
      var date_regex = /((0[13578]|1[02])[\/.](0[1-9]|[12][0-9]|3[01])[\/.](18|19|20)[0-9]{2})|((0[469]|11)[\/.](0[1-9]|[12][0-9]|30)[\/.](18|19|20)[0-9]{2})|((02)[\/.](0[1-9]|1[0-9]|2[0-8])[\/.](18|19|20)[0-9]{2})|((02)[\/.]29[\/.](((18|19|20)(04|08|[2468][048]|[13579][26]))|2000))/;
      if (indate.indexOf("/") != -1) {
        yearnumeric = indate.substring(indate.lastIndexOf("/") + 1);
      } else {
        yearnumeric = indate;
      }
      //Verify the contents
      if (isNaN(yearnumeric) === false && yearnumeric == parseInt(yearnumeric, 10) && date_regex.test(indate) === true) {
        return "Y";
      } else {
        return "N";
      }
    }
    /**
     * Checks for errors and return google analytics array of errors and errors string that is used to append to dom and display error message
     * @param none
     * @return {object} google analytics errors, errors string
     */
    function validationCheck() {
      var rtnErrors = "";
      var rtnErrorsGAFormat = "";
      //form type
      if ($("#ddlFrmType option:selected").text() === "") {

        $("#ddlFrmType").closest("div").prev().find("label").find("strong").addClass("redasterisk");
        rtnErrors += "Form Type is Required<br><br>";
      }
      //filing date blank
      if ($("#txtFilingDate").val() === "") {
        $('label[for="txtFilingDate"]').addClass("redasterisk");
        rtnErrors += "Filing Date is Required<br><br>";
      } else if ($("#txtFilingDate").val().toString().length != 10 || verifydate($("#txtFilingDate").val().toString()) == "N") {
        $('label[for="txtFilingDate"]').addClass("redasterisk");
        rtnErrors += "Filing Date is not in 'mm/dd/yyyy' format<br><br>";
      }
      //security type
      if ($("#ddlSecurityType option:selected").text() === "") {
        $("#ddlSecurityType").closest("div").prev().find("label").find("strong").addClass("redasterisk");
        rtnErrors += "Security Type is Required<br><br>";
      }
      //security title
      if ($("#txtSecurityTitle").val() === "") {
        $("#txtSecurityTitle").closest("div").prev().find("label").find("strong").addClass("redasterisk");
        rtnErrors += "Class of Securities to be Registered is Required<br><br>";
      }
      //no check boxes
      if (anyCheckboxChecked() === false || $("#rchoice457o").is(":checked") === false) {
        //amount to be registered
        if ($("#txtRegAmount").val() === "") {
          $('label[for="txtRegAmount"]').addClass("redasterisk");
          rtnErrors += "Amount to be Registered is Required<br><br>";

        }
        //price per share
        if ($("#txtSharePrice").val() === "") {
          $('label[for="txtSharePrice"]').addClass("redasterisk");
          rtnErrors += "Maximum price per Security is Required<br><br>";
        }
        //max aggregate offering price
        if ($("#txtMaxAggregate").val() === "") {
          rtnErrors += "Maximum Aggregate Offering Price is Required<br><br>";
        }
      }
      //457(o)
      if ($("#rchoice457o").is(":checked")) {
        //max aggregate offering price
        if ($("#txtMaxAggregate").val() === "") {
          $('label[for="txtMaxAggregate"]').addClass("redasterisk");
          rtnErrors += "Maximum Aggregate Offering Price is Required<br><br>";
        }
      }
      if ($("#rchoice457c").is(":checked")) {
        if ($("#txtMarketonWhichSalePriceRprtd").val() === "") {
          rtnErrors += "Market on which " + $('label[for="txtMarketonWhichSalePriceRprtd"]').find('span').text() + " prices were reported is required<br><br>";
        }
        if ($("#txtBidAskDtDate").val() === "") {
          rtnErrors += "Date on which " + $('label[for="txtBidAskDtDate"]').find('span').text() + " prices used for determing maximum price per Security is required<br><br>";
        }
        if ($("#txtLowSharePrice").val() === "") {
          rtnErrors += $('#lblLowAskPriceText').text() + " Price of Security on " + $('.spanMarketDateFrLabel').first().text() + " is required<br><br>";
        }
        if ($("#txtHighSharePrice").val() === "") {
          rtnErrors += $('#lblHighBidPriceText').text() + " Price of Security on " + $('.spanMarketDateFrLabel').first().text() + " is required<br><br>";
        }
      }
      //415(a)(6)
      if ($("#rchoice415a6").is(":checked")) {
        //form type being relied up on for 415(a)(6)
        if ($("#txt415a6_FormType").val() === "") {
          $('label[for="txt415a6_FormType"]').addClass("redasterisk");
          rtnErrors += "Form Type of earlier registration statement from which unsold securities are carried forward in reliance on Rule 415(a)(6) is Required<br><br>";
        }
        //form type being relied up on for 415(a)(6) not in correct format
        else if (inputCheck($("#txt415a6_FormType").val(), "Form Type") === false) {
          $('label[for="txt415a6_FormType"]').addClass("redasterisk");
          rtnErrors += "Form Type of earlier registration statement from which unsold securities are carried forward in reliance on Rule 415(a)(6) is not in Correct Format<br><br>";
        }
        //Effective Date of Filing being relied upon for 415(a)(6):
        if ($("#txt415a6_EffectiveDate").val() === "") {
          $('label[for="txt415a6_EffectiveDate"]').addClass("redasterisk");
          rtnErrors += "Initial Effective Date of earlier registration statement from which unsold securities are carried forward in reliance on Rule 415(a)(6) is Required<br><br>";
        } else if ($("#txt415a6_EffectiveDate").val().toString().length != 10 || verifydate($("#txt415a6_EffectiveDate").val().toString()) == "N") {
          $('label[for="txt415a6_EffectiveDate"]').addClass("redasterisk");
          rtnErrors += "Initial Effective Date of earlier registration statement from which unsold securities are carried forward in reliance on Rule 415(a)(6) is not in 'mm/dd/yyyy' format<br><br>";
        } else {
          //effective date of filing for 415(a)(6) is not within 3 years of filing date
          var filingDate = $("#txtFilingDate").val();
          var effectiveDate415a6 = $("#txt415a6_EffectiveDate").val()
          if (dateWithinYears(filingDate, effectiveDate415a6, 3) === false) {
            rtnErrors += "Not allowed. Expiring securities can only be carried forward for three years.<br><br>";
          }
        }
        if ($("#txt415a6_EffectiveDate").val() === "") {
          $('label[for="txt415a6_EffectiveDate"]').addClass("redasterisk");
        }
        //Aggregate Offering Amount of Unsold Securities being Carried Forward under Rule 415(a)(6):
        if ($("#txt415a6_AggregateOffering").val() === "" && $("#rchoice457o").is(":checked") === true) {
          rtnErrors += "Aggregate Offering Amount of Unsold Securities Carried Forward under Rule 415(a)(6) is Required<br><br>";
        }
        //Aggregate Offering Amount of Unsold Securities being Carried Forward should less than Max Aggregate
        if ((stripCurrency($("#txt415a6_AggregateOffering").val()) - stripCurrency($("#txtMaxAggregate").val())) > 0 && $("#rchoice457o").is(":checked") === true) {

          rtnErrors += "The Maximum Aggregate Offering Price Amount is less than Aggregate Offering Amount of Unsold Securities Carried Forward under Rule 415(a)(6)<br><br>";
        }
        //Number of Unsold Shares being Carried Forward under Rule 415(a)(6):
        if ($("#txt415a6_UnsoldSharesCF").val() === "" && $("#rchoice457o").is(":checked") === false) {

          rtnErrors += "Number of Unsold Securities Carried Forward under Rule 415(a)(6) is Required<br><br>";
        }
        //Number of Unsold Shares being Carried Forward under Rule 415(a)(6) should less than the Amount to be registered:
        if ((stripCurrency($("#txt415a6_UnsoldSharesCF").val()) - stripCurrency($("#txtRegAmount").val())) > 0 && $("#rchoice457o").is(":checked") === false) {
          rtnErrors += "The Amount to be registered is less than the Number of Unsold Securities Carried Forward under Rule 415(a)(6)<br><br>";
        }
        //File Number of Filing Being Relied Upon for 415(a)(6):
        if ($("#txt415a6_FileNumber").val() === "") {
          $('label[for="txt415a6_FileNumber"]').addClass("redasterisk");
          rtnErrors += "File Number of earlier registration statement from which unsold securities are carried forward in reliance on Rule 415(a)(6) is Required<br><br>";
        }
        //File Number of Filing Being Relied Upon for 415(a)(6) not in Correct Format
        else if (inputCheck($("#txt415a6_FileNumber").val(), "File Number") === false) {
          $('label[for="txt415a6_FileNumber"]').addClass("redasterisk");
          rtnErrors += "File Number of earlier registration statement from which unsold securities are carried forward in reliance on Rule 415(a)(6) not in correct format<br><br>";
        }
      }
      //457(p)
      if ($("#rchoice457p").is(":checked")) {
        //CIK being relied upon for 457(p):
        //cik blank
        if ($("#txt457p_CIK").val() === "") {
          rtnErrors += "CIK of filer of registration statement from which a fee offset is claimed under Rule 457(p) is Required<br><br>";
          $('label[for="txt457p_CIK"]').addClass("redasterisk");
        } else if (inputCheck($("#txt457p_CIK").val(), "Number") === false) {
          rtnErrors += "CIK of filer of registration statement from which a fee offset is claimed under Rule 457(p) is not in correct format<br><br>";
        }
        //Form Type being relied upon for 457(p):
        if ($("#txt457p_FormType").val() === "") {
          $('label[for="txt457p_FormType"]').addClass("redasterisk");
          rtnErrors += "Form Type of registration statement from which a fee offset is claimed under Rule 457(p) is Required<br><br>";
        }
        //Form Type being relied upon for 457(p) not in correct format:
        else if (inputCheck($("#txt457p_FormType").val(), "Form Type") === false) {
          $('label[for="txt457p_FormType"]').addClass("redasterisk");
          rtnErrors += "Form Type of registration statement from which a fee offset is claimed under Rule 457(p) is not in correct format<br><br>";
        }
        //Offset Amount:
        if ($("#txt457p_AmountAvailableOffset").val() === "") {
          $('label[for="txt457p_AmountAvailableOffset"]').addClass("redasterisk");
          rtnErrors += "Offset Amount is Required<br><br>";
        }
        //Unsold Maximum Aggregate Offering Price being referenced under Rule 457(p):
        if ($("#txt457p_UnsoldMaxAggregate").val() === "") {
          $('label[for="txt457p_UnsoldMaxAggregate"]').addClass("redasterisk");
          rtnErrors += "Maximum Aggregate Offering Amount of unsold securities from prior registration statement associated with claimed fee offset amount is Required<br><br>";
        }
        //Filing Number of Filing being relied upon for 457(p):
        if ($("#txt457p_FileNumber").val() === "") {
          $('label[for="txt457p_FileNumber"]').addClass("redasterisk");
          rtnErrors += "Filing Number of Filing being relied upon for 457(p) is Required<br><br>";
        }
        //Filing Number of Filing being relied upon for 457(p) not in correct format
        else if (inputCheck($("#txt457p_FileNumber").val(), "File Number") === false) {
          $('label[for="txt457p_FileNumber"]').addClass("redasterisk");
          rtnErrors += "Filing Number of Filing being relied upon for 457(p) is not in correct format<br><br>";
        }
        //Filing Date of Filing being relied upon for 457(p):
        if ($("#txt457p_FilingDate").val() === "") {
          rtnErrors += "Initial Filing Date of registration statement from which a fee offset is claimed under Rule 457(p) is Required<br><br>";
        } else if ($("#txt457p_FilingDate").val().toString().length != 10 || verifydate($("#txt457p_FilingDate").val().toString()) == "N") {
          $('label[for="txt457p_FilingDate"]').addClass("redasterisk");
          rtnErrors += "Initial Filing Date of registration statement from which a fee offset is claimed under Rule 457(p) is not in 'mm/dd/yyyy' format<br><br>";
        } else {
          //filing date upon 457(p) is not within 5 years of filing date
          var filingDate = $("#txtFilingDate").val();
          var filingDate457p = $("#txt457p_FilingDate").val();
          //if (dateWithinYears(filingDate, filingDate457p, 1825) === false) {
          if (dateWithinYears(filingDate, filingDate457p, 5) === false) {
            rtnErrors += "Fees paid against unsold securities can only offset a current Registration Fee for 5 years.<br><br>";
          }
        }
        if ($("#txt457p_FilingDate").val() === "") {
          $('label[for="txt457p_FilingDate"]').addClass("redasterisk");
        }
        if ($("#txtFilingDate").val() === "") {
          $('label[for="txtFilingDate"]').addClass("redasterisk");
        }
        //check to make sure max agg offering under 457(p) * fee rate = amt of available offset
        if ($("#txt457p_AmountAvailableOffset").val() != "" && $("#txt457p_UnsoldMaxAggregate").val() != "") {
          var feeRate = getFeeRate($("#txt457p_FilingDate").val());
          var agg = stripCurrency($("#txt457p_UnsoldMaxAggregate").val());
          var offset = stripCurrency($("#txt457p_AmountAvailableOffset").val());
          //if a difference then show message
          //if (Math.abs(agg * feeRate - offset) >= 1) {
          if ((parseFloat(agg * feeRate).toFixed(2) - parseFloat(offset).toFixed(2)) < 0) {
            rtnErrors += "The Offset Amount should not be greater than the Available Offset Amount.<br><br>";
          }
        }
      }
      //429
      if ($("#rchoice429").is(":checked")) {
        //Prior Registration File Number of filing being relied upon for Rule 429:
        if ($("#txt429_FileNumberPrior").val() === "") {
          $('label[for="txt429_FileNumberPrior"]').addClass("redasterisk")
          rtnErrors += "File Number of prior registration statement to which the combined prospectus relates is Required<br><br>";
        }
        //Prior Registration File Number of filing being relied upon for Rule 429 is not in correct format
        else if (inputCheck($("#txt429_FileNumberPrior").val(), "File Number") == false) {
          $('label[for="txt429_FileNumberPrior"]').addClass("redasterisk")
          rtnErrors += "File Number of prior registration statement to which the combined prospectus relates is not in correct format<br><br>";
        }
        //Prior Registration File Statement Filing Date relied upon for Rule 429:
        if ($("#txt429_PriorRegFilingFormType").val() === "") {
          $('label[for="txt429_PriorRegFilingFormType"]').addClass("redasterisk")
          rtnErrors += "Form Type of prior registration statement to which the combined prospectus relates is Required<br><br>";
        }
        if ($("#txt429_PriorRegFilingFormType").val() === "") {
          $('label[for="txt429_PriorRegFilingFormType"]').addClass("redasterisk")
        }
      }
      if (!$("#inputDisclaimer").is(":checked")) {
        rtnErrors += "Disclaimer agree checkbox is not checked<br><br>";
      }
      //strip last two <br><br>
      rtnErrors = rtnErrors.substring(0, rtnErrors.length - 8);
      if (rtnErrors.length > 0) {
        rtnErrors = "<h3 style='color: white; text-decoration: underline'>Errors</h3><br>" + rtnErrors;
      }
      //populate json array
      var arr = rtnErrors.split(/<br><br>/);
      rtnErrorsGAFormat = JSON.stringify(arr);
      //need to return both strings so put in object
      var rtnErrorObj = {
        ErrorsGAFormat: rtnErrorsGAFormat,
        Errors: rtnErrors
      };
      return rtnErrorObj;
    }
    /**
     * Determines the number of days between two dates and whether the day threshold is <= the difference
     * @param {String/Date} date1
     * @param {String/Date} date2
     * @param {number} yearThreshold
     * @return {boolean} within difference
     */
    function dateWithinYears(date1, date2, yearThreshold) {
      if (date1 == "") {
        date1 = new Date(1900, 1, 1);
      } else if ((date1 instanceof Date) === false) {
        date1 = new Date(date1);
      }
      if (date2 == "") {
        date2 = new Date(1970, 1, 1);
      } else if ((date2 instanceof Date) === false) {
        date2 = new Date(date2);
      }
      var date2Mod = new Date(("0" + (date2.getMonth() + 1)).slice(-2) + "/" + ("0" + date2.getDate()).slice(-2) + "/" + (date2.getFullYear() + yearThreshold));
      var timeDiff = (date2Mod.getTime() - date1.getTime());
      var diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));
      if (diffDays >= 0) {
        return true;
      } else {
        return false;
      }
    }
    /**
     * Determines if any checkbox is on the html page is checked - returns true if so (false is not)
     * @param none
     * @return {boolean} checkbox checked
     */
    function anyCheckboxChecked() {
      var rtn = false;
      $("input[type='checkbox']").each(function() {
        if ($(this).is(":checked")) {
          rtn = true;
        }
      });
      return rtn;
    }
    /**
     * Strips $ and , from a string in currency format
     * @param {string} inp
     * @return {string} currency stripped string
     */
    function stripCurrency(inp) {
      //make sure we have a string since regex only works with string
      inp = inp.toString();
      //strip $ and ,
      return inp.replace("$", "").replace(/,/g, "");
    }
    /**
     * Determine inside tag of html elements (global) and return that; ex: <strong>abc</strong> returns "abc"
     * @param {string} inp
     * @return {string} middle html elements
     */
    function stripHTMLTags(inp) {
      //make sure we have a string since regex only works with string
      inp = inp.toString();
      //only return "middle" element
      return inp.replace(/(<\w+>)(.*?)(<\/\w+>)/g, "$2");
    }
    /**
     * Sets currency/integer/rate/decimal controls on input text boxes so that users can, for example, only enter in currency into a text box
     * @param none
     * @return none
     */
    function setInputControls() {
      $(".currencycontrol").autoNumeric('init', {
        digitGroupSeparator: ',',
        aNeg: '',
        decimalPlacesOverride: 2,
        mNum: 10000,
        currencySymbol: '$'
      });
      $(".integercontrol").autoNumeric('init', {
        digitGroupSeparator: ',',
        aNeg: '',
        decimalPlacesOverride: 0,
        mNum: 10000
      });
      $(".ratecontrol").autoNumeric('init', {
        digitGroupSeparator: '',
        aNeg: '',
        decimalPlacesOverride: 7,
        mNum: 10000
      });
      $(".decimalcontrol").autoNumeric('init', {
        digitGroupSeparator: ',',
        aNeg: '',
        decimalPlacesOverride: 2,
        mNum: 10000
      });
    }
    /**
     * Sets titles on input, select, checkboxes, etc so that hover can show titles
     * @param none
     * @return none
     */
    function setHelpHover() {
      $("#ddlFrmType").prop("title", gHelpText["FormType"]);
      $("#txtFilingDate").prop("title", gHelpText["FilingDate"]);
      $("#rchoice457o").parent().prop("title", gHelpText["Rule457o"]);
      $("#rchoice415a6").parent().prop("title", gHelpText["Rule415a6"]);
      $("#rchoice457p").parent().prop("title", gHelpText["Rule457p"]);
      $("#rchoice429").parent().prop("title", gHelpText["Rule429"]);
      $("#rchoice457c").parent().prop("title", gHelpText["Rule457c"]);
      $("#rchoice457a").parent().prop("title", gHelpText["Rule457a"]);
      $("#rchoice457f").parent().prop("title", gHelpText["Rule 457(f)"]);
      $("#ddlSecurityType").prop("title", gHelpText["SecurityType"]);
      $("#txtSecurityTitle").prop("title", gHelpText["SecurityTitle"]);
      $("#txtRegAmount").prop("title", gHelpText["AmtToBeReg"]);
      $("#txtSharePrice").prop("title", gHelpText["PricePerShare"]);
      $("#txtMaxAggregate").prop("title", gHelpText["MaxAggOffPrice"]);
      $("#txt415a6_FormType").prop("title", gHelpText["FormType415a6"]);
      $("#txt415a6_EffectiveDate").prop("title", gHelpText["EffecDateFiling415a6"]);
      //    $("#txt415a6_FilingDate").prop("title", gHelpText["FilingDate415a6"]);
      $("#txt415a6_AggregateOffering").prop("title", gHelpText["AggOffAmtUnsoldCF415a6"]);
      $("#txt415a6_UnsoldSharesCF").prop("title", gHelpText["AmtUnsoldCF415a6"]);
      $("#txt415a6_FileNumber").prop("title", gHelpText["FileNum415a6"]);
      $("#txt457p_CIK").prop("title", gHelpText["CIK457p"]);
      $("#txt457p_FormType").prop("title", gHelpText["FormType457p"]);
      $("#txt457p_AmountAvailableOffset").prop("title", gHelpText["AmtAvailOffset"]);
      $("#txt457p_UnsoldMaxAggregate").prop("title", gHelpText["UnsoldMaxAggOff457p"]);
      $("#txt457p_FileNumber").prop("title", gHelpText["PriorRegFileNum429"]);
      $("#txt457p_FilingDate").prop("title", gHelpText["FilingDate457p"]);
      $("#txtLowSharePrice").prop("title", gHelpText["HlpLowSharePrice"]);
      $("#txtHighSharePrice").prop("title", gHelpText["HlpHighSharePrice"]);
      //$("#txt429_UnsoldSecuritiesPrior").prop("title", gHelpText["Hlp429_UnsoldSecuritiesPrior"]);
      //$("#txt429_UnsoldShares").prop("title", gHelpText["Hlp429_UnsoldShares"]);
      $("#txt429_FileNumberPrior").prop("title", gHelpText["Hlp429_FileNumberPrior"]);
      $("#txt429_PriorRegFilingFormType").prop("title", gHelpText["Hlp429_PriorRegFilingDate"]);
      $("#ddlMaxPriceSecType").prop("title", gHelpText["MaxPriceSecType"]);
    }
    /**
     * Sets certain input elements to be grayed out
     * @param none
     * @return none
     */
    function setBoxesGrayedOut() {
      $("#txtMaxAggregate").attr("readonly", true);
      $("#txtMaxAggregate").removeClass("input-disabled").addClass("input-disabled");
    }
    /**
     * Determines ids on page with Date word in and binds date controls based off that id
     * @param none
     * @return none
     */
    function setDateControls() {
      $("html input").each(function() {
        var id = $(this).attr("id");
        if (id != undefined) {
          if (id.indexOf("Date") > -1) {
            setDateControl("#" + id);
          }
        }
      });
    }
    /**
     * Binds jquery date control based on input id passed in
     * @param {string} dateControl
     * @return none
     */
    function setDateControl(dateControl) {
      //first unbind the control
      $(dateControl).unbind();
      //now bind it with rules
      // $(dateControl).datepicker();
      /*$(dateControl).pickadate({
          today: '',
          clear: '',
          close: '',
          format: 'mm/dd/yyyy',
          weekdaysShort: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa']
      });*/

      $(dateControl).datepicker({
        autoHide: true,
        //clickInput: true
      }).keydown(function(event) {
        event.preventDefault();
        event.stopPropagation();
        //   KEY MAP
        //  [TAB: 9, LEFT: 37, UP: 38, RIGHT: 39, DOWN: 40]
        var code = event.keyCode || event.which;
        // If key is not TAB
        if (code != '9') {
          // And arrow keys used "for performance on other keys"
          if (code == '37' || code == '38' || code == '39' || code == '40') {
            // Get current date
            var parts = $(this).val().split("/"),
              currentDate = new Date(parts[2], parts[0] - 1, parts[1]);
            if (currentDate == "Invalid Date" || currentDate == "" || currentDate == null || typeof(currentDate) == "undefined") {
              currentDate = new Date();
            }
            // Show next/previous day/week
            switch (code) {
              // LEFT, -1 day
              case 37:
                currentDate.setDate(currentDate.getDate() - 1);
                break;
                // UP, -1 week
              case 38:
                currentDate.setDate(currentDate.getDate() - 7);
                break;
                // RIGHT, +1 day
              case 39:
                currentDate.setDate(currentDate.getDate() + 1);
                break;
                // DOWN, +1 week
              case 40:
                currentDate.setDate(currentDate.getDate() + 7);
                break;
            }
            if (currentDate == "Invalid Date" || currentDate == "" || currentDate == null || typeof(currentDate) == "undefined") {
              $(this).datepicker("setDate", currentDate);
              return false;
            }
          }
        } else {
          console.log("inside tabout else");
          //$(".datepicker-container").removeClass('datepicker-hide').addClass('datepicker-hide')
          var _prev_Input = getPrevNextEle("prev", this);
          var _next_Input = getPrevNextEle("next", this);
          event.shiftKey ? $(_prev_Input).focus() : $(_next_Input).focus();
        }
        if (code == '13') {
          event.preventDefault();
          return false;
        }
      });
    }
    /**
     * Draws modal onto pdf and saves it
     * @param {object} inpObj
     * @return none
     */
    function drawPDFModals() {
      var splitTitle;
      pageNumber = 1;
      var doc = new jsPDF("landscape");
      var yPos = 0;
      var x = 0;
      var y = 0;
      var ytemp = 0;
      doc.setFont("calibri", "normal");
      //DATA ENTRY MODAL
      //header
      doc.setFontStyle("bold");
      doc.setFontSize(18);
      doc.text(x + 120, y + 10, "Data Entry Guide");
      doc.setFontSize(10);
      doc.setFontStyle("normal");
      splitTitle = doc.splitTextToSize("Based on the data entered in the Registration Fee Estimator, the guide below provides suggested  values and content for entry into the Registration Fee Calculation Table, associated footnotes on the filing, as well as the associated values for entry into EDGAR. Additional information related to the calculation logic can be viewed in the Fee Calculation Break Down.", 250);
      doc.text(x + 30, y + 15, splitTitle);
      doc.setFontSize(14);
      doc.setFontStyle("bold");

      doc.setDrawColor(235, 235, 235);
      doc.setFillColor(235, 235, 235);
      doc.rect(x + 30, y + 30, 250, 10, "F");
      doc.setTextColor(39, 58, 86);
      doc.text("Calculation of Registration Fee Table", 115, y + 36);

      doc.setTextColor(0, 0, 0);
      doc.setDrawColor(0, 0, 0);
      doc.setFontSize(12);
      doc.setFontStyle("normal");
      doc.text(x + 45, y + 45, "Applicable Data Fields");
      doc.line(x + 45, y + 46, x + 85, y + 46);
      doc.text(x + 185, y + 45, "Sample");
      doc.line(x + 185, y + 46, x + 198.2, y + 46);
      y = y + 50;
      // x = x + 30;
      doc.setFontSize(11);
      doc.setFontStyle("normal");

      //applicable data fields
      var arr = formatToHtmlAndBackToNormal(gMasterCalculation.dataEntryModal.calcRegFee.dataFields);
      addPDFList(arr, y + 2, 70, x + 35, doc);
      //table
      //header
      doc.setFontSize(11.5);
      doc.text(x + 160, y + 2, "Calculation of Registration Fee Table");
      doc.setFontSize(11);
      doc.line(120, y + 4, 270, y + 4);
      doc.line(120, y + 6, 270, y + 6);
      y = y + 12;
      splitTitle = doc.splitTextToSize("Title of Each Class of Securities to be Registered", 28);
      doc.text(120, y, splitTitle);
      splitTitle = doc.splitTextToSize("Amount to be Registered", 25);
      doc.text(148, y, splitTitle);
      splitTitle = doc.splitTextToSize("Proposed Maximum Offering Price per Unit " + gMasterCalculation.dataEntryModal.calcRegFee.romanNumeralHeadingAppend[0], 30);
      doc.text(173, y, splitTitle);
      splitTitle = doc.splitTextToSize("Proposed Maximum Aggregate Offering Price " + gMasterCalculation.dataEntryModal.calcRegFee.romanNumeralHeadingAppend[1], 30);
      doc.text(203, y, splitTitle);
      splitTitle = doc.splitTextToSize("Amount of Registration Fee" + gMasterCalculation.dataEntryModal.calcRegFee.romanNumeralHeadingAppend[2], 30);
      doc.text(233, y, splitTitle);
      doc.line(120, y + 20, 270, y + 20);
      y = y + 26;
      //line
      splitTitle = doc.splitTextToSize(gMasterCalculation.dataEntryModal.calcRegFee.securityTitle, 28);
      doc.text(x + 120, y, splitTitle);
      var splitLength = splitTitle.length;
      if (gMasterCalculation.dataEntryModal.calcRegFee.amtRegistered === "-") {
        doc.text(gMasterCalculation.dataEntryModal.calcRegFee.amtRegistered, x + 148, y);
      } else {
        splitTitle = doc.splitTextToSize(gMasterCalculation.dataEntryModal.calcRegFee.amtRegistered, 25);
        doc.textEx(splitTitle, x + 170, y, "right", "");
        splitLength = splitTitle.length > splitLength ? splitTitle.length : splitLength;
      }

      if (gMasterCalculation.dataEntryModal.calcRegFee.proposedMaxOffering === "-") {
        doc.text(gMasterCalculation.dataEntryModal.calcRegFee.amtRegistered, x + 173, y);
      } else {
        splitTitle = doc.splitTextToSize(gMasterCalculation.dataEntryModal.calcRegFee.proposedMaxOffering, 30);
        doc.textEx(splitTitle, x + 200, y, "right", "")
        splitLength = splitTitle.length > splitLength ? splitTitle.length : splitLength;
      }
      splitTitle = doc.splitTextToSize(gMasterCalculation.dataEntryModal.calcRegFee.proposedMaxAggOffering, 30);
      doc.textEx(splitTitle, x + 230, y, "right", "");
      splitLength = splitTitle.length > splitLength ? splitTitle.length : splitLength;
      splitTitle = doc.splitTextToSize(gMasterCalculation.dataEntryModal.calcRegFee.amtRegFee, 30);
      doc.textEx(splitTitle, x + 260, y, "right", "");
      splitLength = splitTitle.length > splitLength ? splitTitle.length : splitLength;
      y = (splitLength > 1) ? y + splitLength * 2.5 : y;
      doc.line(x + 120, y + 6, 270, y + 6);
      doc.line(x + 120, y + 8, 270, y + 8);
      y = y + 12;
      doc.setDrawColor(235, 235, 235);
      doc.rect(x + 30, 30, x + 250, y - 30);

      ytemp = y;
      doc.setFontSize(14);
      doc.setFontStyle("bold");

      doc.setDrawColor(235, 235, 235);
      doc.setFillColor(235, 235, 235);
      doc.rect(x + 30, y, 250, 10, "F");
      doc.setTextColor(39, 58, 86);
      doc.text("Filing Footnotes", 130, y + 6);

      doc.setTextColor(0, 0, 0);
      doc.setDrawColor(0, 0, 0);
      doc.setFontSize(12);
      doc.setFontStyle("normal");
      doc.text(x + 45, y + 15, "Applicable Data Fields");
      doc.line(x + 45, y + 16, x + 85, y + 16);
      doc.text(x + 185, y + 15, "Sample");
      doc.line(x + 185, y + 16, x + 198.2, y + 16);
      y = y + 20;

      doc.setFontSize(11);
      arr = formatToHtmlAndBackToNormal(gMasterCalculation.dataEntryModal.footNotes.dataFields);
      var footNtsApplY = addPDFList(arr, y + 2, 70, x + 35, doc);
      var footNtsApplPageNumber = doc.internal.getCurrentPageInfo()["pageNumber"];
      //sample
      doc.setPage(1);
      pageNumber = 1;
      Hyphen = false;
      var arr = formatToHtmlAndBackToNormal(gMasterCalculation.dataEntryModal.footNotes.filingFootnotes);
      var footNtsSamY = addPDFList(arr, y + 2, 150, x + 120, doc);
      var footNtsSamPageNumber = doc.internal.getCurrentPageInfo()["pageNumber"];
      y = footNtsApplPageNumber == footNtsSamPageNumber ? footNtsApplY > footNtsSamY ? footNtsApplY : footNtsSamY : footNtsApplY > footNtsSamY ? footNtsSamY : footNtsApplY;
      y = y + 4;
      if (doc.internal.getNumberOfPages() > 1) {
        doc.setPage(1);
        doc.setDrawColor(235, 235, 235);
        doc.rect(x + 30, ytemp, x + 250, 205 - ytemp);
        doc.setPage(2);
        doc.setDrawColor(235, 235, 235);
        doc.rect(x + 30, 5, x + 250, y - 5);
      } else {
        doc.setDrawColor(235, 235, 235);
        doc.rect(x + 30, ytemp, x + 250, y - ytemp);
      }
      Hyphen = true;
      //write on new page if footnotes chars is greater than 500

      if (y > 160) {
        doc.addPage();
        y = 10;
      }
      pageNumber = doc.internal.getNumberOfPages();
      ytemp = y;
      doc.setFontSize(14);
      doc.setFontStyle("bold");

      doc.setDrawColor(235, 235, 235);
      doc.setFillColor(235, 235, 235);
      doc.rect(x + 30, y, 250, 10, "F");
      doc.setTextColor(39, 58, 86);
      doc.text("EDGAR Header", 133, y + 6);

      doc.setTextColor(0, 0, 0);
      doc.setDrawColor(0, 0, 0);
      doc.setFontSize(12);
      doc.setFontStyle("normal");
      doc.text(x + 45, y + 15, "Applicable Data Fields");
      doc.line(x + 45, y + 16, x + 85, y + 16);
      doc.text(x + 185, y + 15, "Sample");
      doc.line(x + 185, y + 16, x + 198.2, y + 16);
      y = y + 20;
      doc.setFontSize(11);
      arr = formatToHtmlAndBackToNormal(gMasterCalculation.dataEntryModal.edgarHeader.offAndFees.dataFields);
      var offeringApplY = addPDFList(arr, y + 2, 70, x + 35, doc);
      doc.setPage(pageNumber);
      doc.setFontSize(11.5);
      doc.text(x + 180, y + 2, "Offering and Fees");
      doc.setFontSize(11);
      var ytemp1 = y + 4;
      doc.setFillColor(153, 204, 255);
      doc.rect(x + 120, ytemp1, 155, 13, "F");
      y = y + 10;
      splitTitle = doc.splitTextToSize("Security Type", 30);
      doc.text(125, y, splitTitle);
      splitTitle = doc.splitTextToSize("Amount to be Registered", 30);
      doc.text(155, y, splitTitle);
      splitTitle = doc.splitTextToSize("Proposed Maximum Offering Price per Unit", 40);
      doc.text(185, y, splitTitle);
      splitTitle = doc.splitTextToSize("Proposed Maximum Aggregate Offering Price", 50);
      doc.text(225, y, splitTitle);
      y = y + 12;
      splitTitle = doc.splitTextToSize(gMasterCalculation.dataEntryModal.edgarHeader.offAndFees.securityType, 30);
      doc.text(125, y, splitTitle);
      splitLength = splitTitle.length;
      if (gMasterCalculation.dataEntryModal.edgarHeader.offAndFees.amtRegistered === "-") {
        doc.text(155, y, gMasterCalculation.dataEntryModal.edgarHeader.offAndFees.amtRegistered);
      } else {
        splitTitle = doc.splitTextToSize(gMasterCalculation.dataEntryModal.edgarHeader.offAndFees.amtRegistered, 40);
        doc.textEx(splitTitle, x + 180, y, "right", "");
        splitLength = splitTitle.length > splitLength ? splitTitle.length : splitLength;
      }
      if (gMasterCalculation.dataEntryModal.edgarHeader.offAndFees.proposedMaxOffering === "-") {
        doc.text(185, y, gMasterCalculation.dataEntryModal.edgarHeader.offAndFees.proposedMaxOffering);
      } else {
        splitTitle = doc.splitTextToSize(gMasterCalculation.dataEntryModal.edgarHeader.offAndFees.proposedMaxOffering, 40);
        doc.textEx(splitTitle, x + 223, y, "right", "");
        splitLength = splitTitle.length > splitLength ? splitTitle.length : splitLength;

      }
      splitTitle = doc.splitTextToSize(gMasterCalculation.dataEntryModal.edgarHeader.offAndFees.proposedMaxAggOffering, 50);
      doc.textEx(splitTitle, x + 268, y, "right", "");
      splitLength = splitTitle.length > splitLength ? splitTitle.length : splitLength;
      y = (splitLength > 1) ? y + splitLength * 2.5 : y;
      y = y + 2;
      doc.setDrawColor(235, 235, 235);
      doc.rect(x + 120, ytemp1, x + 155, y - ytemp1);
      y = y + 2;

      if (gMasterCalculation.dataEntryModal.edgarHeader.feeAndOffset.formType != "") {

        //applicable data fields
        if (y > 160) {
          doc.addPage();
          y = 10;
        }
        var arr = formatToHtmlAndBackToNormal(gMasterCalculation.dataEntryModal.edgarHeader.feeAndOffset.dataFields);
        var offSetApplnY = addPDFList(arr, y + 7, 70, x + 35, doc);
        //table
        doc.setFontSize(11.5);
        doc.text(x + 175, y + 6, "Fee Offset Information");
        doc.setFontSize(11);

        var ytemp2 = y + 8;
        doc.setFillColor(153, 204, 255);
        doc.rect(x + 120, ytemp2, 155, 10, "F");
        y = y + 13;
        splitTitle = doc.splitTextToSize("CIK", 25);
        doc.text(125, y, splitTitle);
        splitTitle = doc.splitTextToSize("Form Type", 25);
        doc.text(150, y, splitTitle);
        splitTitle = doc.splitTextToSize("File Number", 30);
        doc.text(175, y, splitTitle);
        splitTitle = doc.splitTextToSize("Offset Filing Date", 30);
        doc.text(205, y, splitTitle);
        splitTitle = doc.splitTextToSize("Amount", 50);
        doc.text(245, y, splitTitle);
        y = y + 12;

        splitTitle = doc.splitTextToSize(gMasterCalculation.dataEntryModal.edgarHeader.feeAndOffset.cik, 30);
        doc.text(125, y, splitTitle);
        splitLength = splitTitle.length;

        splitTitle = doc.splitTextToSize(gMasterCalculation.dataEntryModal.edgarHeader.feeAndOffset.formType, 30);
        doc.text(150, y, splitTitle);
        splitLength = splitTitle.length > splitLength ? splitTitle.length : splitLength;

        splitTitle = doc.splitTextToSize(gMasterCalculation.dataEntryModal.edgarHeader.feeAndOffset.fileNumber, 30);
        doc.text(175, y, splitTitle);
        splitLength = splitTitle.length > splitLength ? splitTitle.length : splitLength;

        splitTitle = doc.splitTextToSize(gMasterCalculation.dataEntryModal.edgarHeader.feeAndOffset.offsetFilingDate, 30);
        doc.text(205, y, splitTitle);
        splitLength = splitTitle.length > splitLength ? splitTitle.length : splitLength;

        splitTitle = doc.splitTextToSize(gMasterCalculation.dataEntryModal.edgarHeader.feeAndOffset.amt, 40);
        doc.textEx(splitTitle, x + 268, y, "right", "");
        splitLength = splitTitle.length > splitLength ? splitTitle.length : splitLength;

        y = (splitLength > 1) ? y + splitLength * 2.5 : y;
        y = y + 5;
        doc.setDrawColor(235, 235, 235);
        doc.rect(x + 120, ytemp2, x + 155, y - ytemp2);
        y = y + 10;
      }
      y = y + 5;
      doc.setDrawColor(235, 235, 235);
      doc.rect(x + 30, ytemp, x + 250, y - ytemp);

      doc.addPage();
      y = 10;
      doc.setFontStyle("bold");
      doc.setFontSize(18);
      doc.text(x + 70, y, "Registration Fee and Net Fee Calculation Breakdown");
      doc.setFontSize(14);
      doc.setFontStyle("normal");
      doc.text(x + 32, y + 10, $("#netFeeTableTab > div:nth-child(2) p").text()); //"The Registration Fee for the following securities is based on the Maximum Aggregate Offering Price:");
      y = y + 20;
      doc.setFontSize(11);
      doc.setFontStyle("normal");
      ytemp = y;
      y = y + 5;
      //first table
      //457(o)
      if (gMasterCalculation.netFeeModal.chosenOorA === "o") {
        //header
        doc.setFillColor(153, 204, 255);
        doc.rect(x + 40, ytemp, 200, 13, "F");

        splitTitle = doc.splitTextToSize("Class of Securities to be Registered", 35);
        doc.text(45, y, splitTitle);

        splitTitle = doc.splitTextToSize("Aggregate", 50);
        doc.text(95, y, splitTitle);

        splitTitle = doc.splitTextToSize("Aggregate Carried Forward", 50);
        doc.text(130, y, splitTitle);

        splitTitle = doc.splitTextToSize("Adjusted Gross Aggregate (less Carry Forward)", 50);
        doc.text(180, y, splitTitle);

        y = y + 15;

        splitTitle = doc.splitTextToSize(gMasterCalculation.netFeeModal._457o.securityTitle, 30);
        doc.text(45, y, splitTitle);
        splitLength = splitTitle.length;

        splitTitle = doc.splitTextToSize(gMasterCalculation.netFeeModal._457o.aggregate, 50);
        doc.textEx(splitTitle, x + 125, y, "right", "");
        splitLength = splitTitle.length > splitLength ? splitTitle.length : splitLength;

        splitTitle = doc.splitTextToSize(gMasterCalculation.netFeeModal._457o.aggCarriedForward, 50);
        doc.textEx(splitTitle, x + 175, y, "right", "");
        splitLength = splitTitle.length > splitLength ? splitTitle.length : splitLength;

        splitTitle = doc.splitTextToSize(gMasterCalculation.netFeeModal._457o.adjGrossAggregate, 50);
        doc.textEx(splitTitle, x + 225, y, "right", "");
        splitLength = splitTitle.length > splitLength ? splitTitle.length : splitLength;
        y = (splitLength > 1) ? y + splitLength * 2.5 : y;
        y = y + 5;
        //blue line
        doc.setDrawColor(153, 204, 255);
        doc.line(40, y, 240, y);
        doc.text(x + 158, y + 6, "Aggregate");
        splitTitle = doc.splitTextToSize(gMasterCalculation.netFeeModal._457o.adjGrossAggregate, 50);
        doc.textEx(splitTitle, x + 225, y + 6, "right", "");
        y = y + splitTitle.length * 2.5 + 7;
        doc.setDrawColor(235, 235, 235);
        doc.rect(x + 40, ytemp, x + 200, y - ytemp);
      }
      //header 457(a)
      else if (gMasterCalculation.netFeeModal.chosenOorA === "a") {
        doc.setFillColor(153, 204, 255);
        doc.rect(x + 40, ytemp, 200, 20, "F");
        splitTitle = doc.splitTextToSize("Class of Securities to be Registered", 25);
        doc.text(45, y, splitTitle);
        splitTitle = doc.splitTextToSize("Amount to be Registered", 30);
        doc.text(72, y, splitTitle);
        splitTitle = doc.splitTextToSize("Amount Carried Forward", 30);
        doc.text(100, y, splitTitle);
        splitTitle = doc.splitTextToSize("Adjusted Amount (less Carry Forward)", 30);
        doc.text(130, y, splitTitle);
        splitTitle = doc.splitTextToSize("Maximum price per Security", 30);
        doc.text(160, y, splitTitle);
        splitTitle = doc.splitTextToSize("Maximum Aggregate Offering Price", 45);
        doc.text(192, y, splitTitle);
        doc.setFontStyle("normal");

        y = y + 20;

        splitTitle = doc.splitTextToSize(gMasterCalculation.netFeeModal._457a.securityTitle, 25);
        doc.text(45, y, splitTitle);
        splitLength = splitTitle.length;

        splitTitle = doc.splitTextToSize(gMasterCalculation.netFeeModal._457a.amtRegistered, 30);
        doc.textEx(splitTitle, x + 95, y, "right", "");
        splitLength = splitTitle.length > splitLength ? splitTitle.length : splitLength;

        splitTitle = doc.splitTextToSize(gMasterCalculation.netFeeModal._457a.amtCarriedForward, 30);
        doc.textEx(splitTitle, x + 125, y, "right", "");
        splitLength = splitTitle.length > splitLength ? splitTitle.length : splitLength;

        splitTitle = doc.splitTextToSize(gMasterCalculation.netFeeModal._457a.adjAmt, 30);
        doc.textEx(splitTitle, x + 155, y, "right", "");
        splitLength = splitTitle.length > splitLength ? splitTitle.length : splitLength;

        splitTitle = doc.splitTextToSize(gMasterCalculation.netFeeModal._457a.priceShare, 30);
        doc.textEx(splitTitle, x + 185, y, "right", "");
        splitLength = splitTitle.length > splitLength ? splitTitle.length : splitLength;

        splitTitle = doc.splitTextToSize(gMasterCalculation.netFeeModal._457a.maxAggOffering, 45);
        doc.textEx(splitTitle, x + 235, y, "right", "");
        splitLength = splitTitle.length > splitLength ? splitTitle.length : splitLength;

        y = (splitLength > 1) ? y + splitLength * 2.5 : y;
        y = y + 5;
        //blue line
        doc.setDrawColor(153, 204, 255);
        doc.line(40, y, 240, y);
        doc.text(x + 170, y + 6, "Aggregate");
        splitTitle = doc.splitTextToSize(gMasterCalculation.netFeeModal._457a.totAggregate, 50);
        doc.textEx(splitTitle, x + 235, y + 6, "right", "");
        y = y + splitTitle.length * 2.5 + 7;
        doc.setDrawColor(235, 235, 235);
        doc.rect(x + 40, ytemp, x + 200, y - ytemp);
      }
      ytemp = y;
      y = y + 7;

      //bottom box
      //header
      doc.setFontStyle("bold");
      splitTitle = doc.splitTextToSize("Total Aggregate", 30);
      doc.text(170, y, splitTitle);
      doc.setFontStyle("normal");
      splitTitle = doc.splitTextToSize("Fee Rate", 30);
      doc.text(170, y + 7, splitTitle);
      doc.setFontStyle("bold");
      doc.text(200, y + 7, "X");
      doc.setFontStyle("normal");
      splitTitle = doc.splitTextToSize("Registration Fee", 30);
      doc.text(170, y + 14, splitTitle);
      splitTitle = doc.splitTextToSize("Offset", 30);
      doc.text(170, y + 21, splitTitle);
      doc.setFontStyle("bold");
      doc.text(200, y + 21, "-");
      splitTitle = doc.splitTextToSize("Net Fee", 30);
      doc.text(170, y + 28, splitTitle);
      doc.setFontStyle("normal");
      doc.setDrawColor(0, 0, 0);
      //line
      if (gMasterCalculation.netFeeModal.chosenOorA === "o") {
        //Rule 429 text
        if (!(gMasterCalculation.netFeeModal._457o._429Note === "")) {
          splitTitle = doc.splitTextToSize(gHelpText["NetFeeModal429Hover"], 100);
          doc.text(splitTitle, x + 45, y + 5);
        }
        doc.textEx(gMasterCalculation.netFeeModal._457o.totAggregate, 235, y, "right", "");
        doc.textEx(String(gMasterCalculation.netFeeModal._457o.feeRate), 235, y + 7, "right", "");
        doc.line(210, y + 10, 235, y + 10);
        doc.textEx(gMasterCalculation.netFeeModal._457o.regFee, 235, y + 14, "right", "");
        doc.textEx(gMasterCalculation.netFeeModal._457o.offset, 235, y + 21, "right", "");
        doc.line(210, y + 24, 235, y + 24);
        doc.setFontStyle("bold");
        doc.textEx(gMasterCalculation.netFeeModal._457o.netFee, 235, y + 28, "right", "");
      } else if (gMasterCalculation.netFeeModal.chosenOorA === "a") {
        //Rule 429 text
        if (!(gMasterCalculation.netFeeModal._457a._429Note === "")) {
          splitTitle = doc.splitTextToSize(gHelpText["NetFeeModal429Hover"], 100);
          doc.text(splitTitle, x + 45, y + 5);
        }
        doc.textEx(gMasterCalculation.netFeeModal._457a.totAggregate, 235, y, "right", "");
        doc.textEx(String(gMasterCalculation.netFeeModal._457a.feeRate), 235, y + 7, "right", "");
        doc.line(200, y + 10, 235, y + 10);
        doc.textEx(gMasterCalculation.netFeeModal._457a.regFee, 235, y + 14, "right", "");
        doc.textEx(gMasterCalculation.netFeeModal._457a.offset, 235, y + 21, "right", "");
        doc.line(200, y + 24, 235, y + 24);
        doc.setFontStyle("bold");
        doc.textEx(gMasterCalculation.netFeeModal._457a.netFee, 235, y + 28, "right", "");
      }
      y = y + 35;

      doc.setDrawColor(235, 235, 235);
      doc.rect(x + 165, ytemp, 75, y - ytemp);

      doc.setTextColor(255, 0, 0);
      doc.setFontSize(9);
      splitTitle = doc.splitTextToSize(stripHTMLTags(gDisclaimer), 250);
      doc.text(30, 180, splitTitle);

      doc.save('export_feeestimator.pdf');
    }

    function addPDFList(inpArr, yPos, colWidth, xPos, doc) {
      var splitTitle;
      for (var i = 0; i < inpArr.length; i++) {
        splitTitle = Hyphen ? doc.splitTextToSize("- " + inpArr[i], colWidth) : doc.splitTextToSize(inpArr[i], colWidth);
        doc.text(xPos, yPos, splitTitle);
        var isNewPageTrue = xPos < 50 && yPos > 190 ? true : xPos > 50 && yPos > 175 ? true : false;
        if (isNewPageTrue) {
          if (pageNumber == doc.internal.getNumberOfPages()) {
            doc.addPage();
          } else {
            doc.setPage(doc.internal.getNumberOfPages());
          }
          yPos = 10;
        } else {
          yPos += splitTitlePos(splitTitle);
        }
      }
      return yPos;
    }

    function splitTitlePos(splitTitle) {
      var yPos = 0;
      for (var i = 0; i <= splitTitle.length; i++) {
        yPos += 4; //3.5;
      }
      return yPos;
    }
    /**
     * Used for pdf writing, determines vertical spacing needed and returns that
     * @param {string} inp
     * @return {number} spacing
     */
    function positionVariableLength(inp) {
      if (inp.length <= 3) {
        return inp.length * 1;
      } else if (inp.length <= 5) {
        return inp.length * 1.15;
      } else if (inp.length <= 6) {
        return inp.length * 1.2;
      } else if (inp.length <= 7) {
        return inp.length * 1.4;
      } else if (inp.length <= 8) {
        return inp.length * 1.4;
      } else if (inp.length <= 9) {
        return inp.length * 1.5;
      } else if (inp.length <= 11) {
        return inp.length * 1.55;
      } else {
        return inp.length * 1.65;
      }
    }
  });

  function fadeOutAllScreens() {
    $("#feeestimatorform").fadeOut(200);
    $("#dataEntryTab").fadeOut(200);
    $("#netFeeTableTab").fadeOut(200);
    $("#tableNetFee457A").fadeOut(200);
    $("#tableNetFee457O").fadeOut(200);
    if ($('.focusText').length > 0) { // remove highlighted text
      $('.focusText').removeClass('focusText');
    }
  }

  function clearFormElements(id) {
    $(id).find('input[type=text]').val('');
    $(id).find('textarea').val('');
    $(id).find('input[type=checkbox]').removeAttr('checked');
    $(id).find('input[type=radio]').prop('checked', false)
    $(id).find("select").each(function() {
      $(this).removeAttr('selected');
      $(this).prop("selectedIndex", 0);
    });
  }

  function formatToHtmlAndBackToNormal(arrText) {
    var tempArray = [];
    $.each(arrText, function(key, value) {
      $("#hiddenDiv").html(value);
      tempArray.push($("#hiddenDiv").text());
    });
    return tempArray;
  }

  function getPrevNextEle(_prev_Next, thisEl) {
    var input = "";
    if (_prev_Next.toUpperCase() == "PREV") {
      var prev_El = $(':input:eq(' + ($(':input').index(thisEl) - 1) + ')');
      if (typeof prev_El != "undefined") {
        input = !$(prev_El).is(':visible') ? getPrevNextEle("prev", prev_El) : typeof $(prev_El).attr("disabled") != "undefined" && $(prev_El).attr("disabled") != false ? getPrevNextEle("prev", prev_El) : prev_El;
      }
    } else if (_prev_Next.toUpperCase() == "NEXT") {
      var next_El = $(':input:eq(' + ($(':input').index(thisEl) + 1) + ')');
      if (typeof next_El != "undefined") {
        input = !$(next_El).is(':visible') ? getPrevNextEle("next", next_El) : typeof $(next_El).attr("disabled") != "undefined" && $(next_El).attr("disabled") != false ? getPrevNextEle("next", next_El) : next_El;
      }
    }
    return input;
  }
});
