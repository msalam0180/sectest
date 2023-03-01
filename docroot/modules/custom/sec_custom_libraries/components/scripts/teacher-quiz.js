jQuery(function($) {

  $(function(){

    $('#quiz').quiz({
      //counter: false,
      //startScreen: '#quiz-start-screen',
      //startButton: '#quiz-start-btn',
      //resultsScreen: '#quiz-results-screen',
      homeButton: '.close-modal',
      counterFormat: 'Question %current of %total',

      questions: [
        {
          'q': '403(b) and 457(b) plans are common retirement plans offered to teachers. Do teachers have to pay taxes on these plans?',
          'options': [
            'No! Teachers get a pass!',
            'Of course. The government always wants more taxes.',
            'Yes, pre-tax contributions will be taxed at the time of withdrawal, typically at the time of retirement.',
            'You never really know about taxes. Maybe you will.',
            'All of the above.'
          ],
          'correctIndex': 2,
          'correctResponse': '<strong>CORRECT!</strong> Similar to <a href="https://investor.gov/introduction-investing/retirement-plans/employer-sponsored-plans/traditional-roth-401k-plans" target="_blank">401(k) plans</a>, 403(b) and 457(b) plans allow you to contribute pre-tax money from your paycheck to your 403(b) or 457(b) plan to invest in certain investment products. These pre-tax contributions and their investment earnings will not be taxed until you withdraw the money, typically after you retire.',
          'incorrectResponse': '<strong>INCORRECT! The answer is C.</strong> Similar to <a href="https://investor.gov/introduction-investing/retirement-plans/employer-sponsored-plans/traditional-roth-401k-plans" target="_blank">401(k) plans</a>, 403(b) and 457(b) plans allow you to contribute pre-tax money from your paycheck to your 403(b) or 457(b) plan to invest in certain investment products. These pre-tax contributions and their investment earnings will not be taxed until you withdraw the money, typically after you retire.'
        },
        {
          'q': 'How much can I contribute to my 403(b) or 457(b) plan?',
          'options': [
            'Why worry about it now? Just contribute the minimum.',
            'There are many ways to calculate what kind of savings you may need for retirement, however, the IRS determines the annual contribution limits for both 403(b) and 457(b) plans, and there are annual contribution caps.',
            'Your entire paycheck. No one knows what tomorrow holds.',
            'Nothing at all. Best to put your paycheck in your mattress.'
          ],
          'correctIndex': 1,
          'correctResponse': '<strong>CORRECT!</strong> The IRS determines the annual contribution limits for both 403(b) and 457(b) plans. Each plan has specific rules governing contribution limits and “catch-up contributions.”  You can review these rules on the IRS’s website (<a href="https://www.irs.gov/retirement-plans/plan-participant-employee/retirement-topics-403b-contribution-limits" target="_blank">403(b) contributions</a>, <a href="https://www.irs.gov/retirement-plans/plan-participant-employee/retirement-topics-457b-contribution-limits" target="_blank">457(b) contributions</a>).',
          'incorrectResponse': '<strong>INCORRECT! The answer is B.</strong> The IRS determines the annual contribution limits for both 403(b) and 457(b) plans. Each plan has specific rules governing contribution limits and “catch-up contributions.”  You can review these rules on the IRS’s website (<a href="https://www.irs.gov/retirement-plans/plan-participant-employee/retirement-topics-403b-contribution-limits" target="_blank">403(b) contributions</a>, <a href="https://www.irs.gov/retirement-plans/plan-participant-employee/retirement-topics-457b-contribution-limits" target="_blank">457(b) contributions</a>).'
        },
        {
          'q': 'My employer has several 403(b) and 457(b) plan vendors to choose from. How should I select a vendor?',
          'options': [
            'This is not a Magic 8 Ball. Just pick one.',
            'Outlook unclear. Ask again later.',
            'Try to learn as much as you can about each vendor and ask about their fees. You want to know about their background and about the products they are offering before you make any choices.',
            'None of the above.'
          ],
          'correctIndex': 2,
          'correctResponse': '<strong>CORRECT!</strong> Pay attention to the selection of vendors offered by your employer. Research each one, including the fees that may be associated with the vendor’s services. If the financial professional is required to register with a regulator, find out which one and look up their background. You can find more tips on how to select a vendor on <a href="https://investor.gov/introduction-investing/retirement-plans/employer-sponsored-plans/403b-457b-plans" target="_blank">Investor.gov</a>.',
          'incorrectResponse': '<strong>INCORRECT! The answer is C.</strong> Pay attention to the selection of vendors offered by your employer. Research each one, including the fees that may be associated with the vendor’s services. If the financial professional is required to register with a regulator, find out which one and look up their background. You can find more tips on how to select a vendor on <a href="https://investor.gov/introduction-investing/retirement-plans/employer-sponsored-plans/403b-457b-plans" target="_blank">Investor.gov</a>.'
        },
        {
          'q': 'I did my homework and found out about the vendors my employer is offering plans through, but I am not sure if I have to pay fees to the vendors. What should I do?',
          'options': [
            'During your research, ask the vendor rep if there are any fees. If he or she says no, ask if that only applies to "up front fees."',
            'Seek out any literature or forms that may have an outline of the fees the vendor charges.',
            'Both A & B.',
            'None of the above.'
          ],
          'correctIndex': 2,
          'correctResponse': '<strong>CORRECT!</strong> Before selecting a vendor you want to be sure of the fees associated with the plan. Don’t be afraid to ask about the fees and even inquire if there is a list or outline of the fees. For more information about fees and how to read the fine print, visit <a href="https://investor.gov/introduction-investing/retirement-plans/employer-sponsored-plans/403b-457b-plans" target="_blank">Investor.gov</a>.',
          'incorrectResponse': '<strong>INCORRECT! The answer is C.</strong> Before selecting a vendor you want to be sure of the fees associated with the plan. Don’t be afraid to ask about the fees and even inquire if there is a list or outline of the fees. For more information about fees and how to read the fine print, visit <a href="https://investor.gov/introduction-investing/retirement-plans/employer-sponsored-plans/403b-457b-plans" target="_blank">Investor.gov</a>.'
        },
        {
          'q': 'My employer offers one vendor, but there are so many investment products offered. How should I select investment products for my 403(b) or 457(b) plan?',
          'options': [
            'Let the rep tell you!',
            'Commonly, annuities and mutual funds are offered to 403(b) and 457 (b) plan participants. Learn more about these products, then go back and see which one fits your retirement savings profile.',
            'Just put your money in a savings account and decide later.',
            'Look for the most expensive letterhead.',
            'All of the above.'
          ],
          'correctIndex': 1,
          'correctResponse': '<strong>CORRECT!</strong> As a participant in a 403(b) or 457(b) plan, you may need to choose among different types of investments. Typically, 403(b) and 457(b) plans offer two types of investment products – annuities and mutual funds. Learn more about these kinds of products at <a href="https://investor.gov" target="_blank">Investor.gov</a> and then look at what kind of contribution you want to make. Make sure you understand all of the pro’s and con’s before committing to a product.',
          'incorrectResponse': '<strong>INCORRECT! The answer is B.</strong> As a participant in a 403(b) or 457(b) plan, you may need to choose among different types of investments. Typically, 403(b) and 457(b) plans offer two types of investment products – annuities and mutual funds. Learn more about these kinds of products at <a href="https://investor.gov" target="_blank">Investor.gov</a> and then look at what kind of contribution you want to make. Make sure you understand all of the pro’s and con’s before committing to a product.'
        }
      ]
    });

  
    $("#quiz-restart-btn").html("Quit").attr("rel", "modal:close");

    $("<p>Now that you are started in the right direction, keep learning! Find more tips for investing wisely at <a href='https://investor.gov' target='_blank'>Investor.gov</a> and get saving!</p>").appendTo("#quiz-results-screen");

    $("<a href='#' id='quiz-overlay' class='close-modal' rel='modal:close' style='position:fixed;'></a>").prependTo("body");

    $("body > :not(.quiz-container)").click(function() {
      //event.preventDefault();

      setTimeout(function() {
        if ($("#quiz").is(".modal")) {
          //$("#quiz-overlay").css({"zIndex" : "1", "display" : "block", "backgroundColor": "#000", "opacity": ".8", "height" : "100%", "width" : "100%"});
          $("#quiz-overlay").css({"zIndex" : "1", "display" : "block", "height" : "100%", "width" : "100%"});
          console.log("This has the modal class!");
        } else {
          $("#quiz-overlay").css({"zIndex" : "0", "display" : "none", "height" : "0", "width" : "0"});
          console.log("This does NOT have the modal class!");
        }
      }, 100);

    });


  });

});