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
          'q': 'Question 1?',
          'options': [
            'Response Choice A.',
            'Response Choice B.',
            'Response Choice C.',
            'Response Choice D.',
            'Response Choice E.'
          ],
          'correctIndex': 2,
          'correctResponse': '<strong>CORRECT!</strong> Here is some further guidance text explaining more about this question topic. For more information, check out this <a href="#" target="_blank">Site: Article</a>.',
          'incorrectResponse': '<strong>INCORRECT! The answer is C.</strong> Here is some explanation text about why this is the correct answer and additional info about this question topic. For more information, check out <a href="#" target="_blank">Site: Article</a>.'
        },
        {
          'q': 'Question 2?',
          'options': [
            'Response Choice A.',
            'Response Choice B.',
            'Response Choice C.',
            'Response Choice D.'
          ],
          'correctIndex': 1,
          'correctResponse': '<strong>CORRECT!</strong> Here is some further guidance text explaining more about this question topic. For more information, check out this <a href="#" target="_blank">Site: Article</a>.',
          'incorrectResponse': '<strong>INCORRECT! The answer is B.</strong> Here is some explanation text about why this is the correct answer and additional info about this question topic. For more information, check out <a href="#" target="_blank">Site: Article</a>.'
        },
        {
          'q': 'Question 3?',
          'options': [
            'Response Choice A.',
            'Response Choice B.',
            'Response Choice C.',
            'Response Choice D.'
          ],
          'correctIndex': 3,
          'correctResponse': '<strong>CORRECT!</strong> Here is some further guidance text explaining more about this question topic. For more information, check out this <a href="#" target="_blank">Site: Article</a>.',
          'incorrectResponse': '<strong>INCORRECT! The answer is D.</strong> Here is some explanation text about why this is the correct answer and additional info about this question topic. For more information, check out <a href="#" target="_blank">Site: Article</a>.'
        },
        {
          'q': 'Question 4?',
          'options': [
            'Response Choice A.',
            'Response Choice B.',
            'Response Choice C.',
            'Response Choice D.'
          ],
          'correctIndex': 0,
          'correctResponse': '<strong>CORRECT!</strong> Here is some further guidance text explaining more about this question topic. For more information, check out this <a href="#" target="_blank">Site: Article</a>.',
          'incorrectResponse': '<strong>INCORRECT! The answer is A.</strong> Here is some explanation text about why this is the correct answer and additional info about this question topic. For more information, check out <a href="#" target="_blank">Site: Article</a>.'
        },
        {
          'q': 'Question 5?',
          'options': [
            'Response Choice A.',
            'Response Choice B.',
            'Response Choice C.',
            'Response Choice D.',
            'Response Choice E.'
          ],
          'correctIndex': 2,
          'correctResponse': '<strong>CORRECT!</strong> Here is some further guidance text explaining more about this question topic. For more information, check out this <a href="#" target="_blank">Site: Article</a>.',
          'incorrectResponse': '<strong>INCORRECT! The answer is C.</strong> Here is some explanation text about why this is the correct answer and additional info about this question topic. For more information, check out <a href="#" target="_blank">Site: Article</a>.'
        }
      ]
    });

  
    $("#quiz-restart-btn").html("Quit").attr("rel", "modal:close");

    $("<p>Do you think you’re ready? For more information, check out our <a href='#' target='_blank'>Site: Article</a>.</p>").appendTo("#quiz-results-screen");
   
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