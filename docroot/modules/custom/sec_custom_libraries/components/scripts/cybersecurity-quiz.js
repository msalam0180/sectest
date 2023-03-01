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
          'q': 'You get an email from your broker telling you your information has been compromised and you need to click on a link in the email to update your login information. What do you do?',
          'options': [
            'Click on the link, fast, before someone logs in and takes all of your money.',
            'Call the number provided in the email to see if the email is legitimate before you click the link.',
            'Do not click on the link. Look up the contact information of your broker and contact them to see if your information was compromised.',
            'Ignore it. You get too many annoying emails.',
            'Forward to everyone you know and ask them if they think it’s suspicious.'
          ],
          'correctIndex': 2,
          'correctResponse': '<strong>CORRECT!</strong> Look up your broker’s contact information, or log into your broker’s website. The email you received could be from a bad actor, so you shouldn’t automatically trust the contact information it contains. You don’t want to ignore an email either, but think before clicking on links or providing personal information, even if the email looks official. For more information, check out <a href="https://investor.gov/additional-resources/news-alerts/alerts-bulletins/updated-investor-bulletin-protecting-your-online" target="_blank">Investor Bulletin: Protecting Your Online Investment Accounts From Fraud</a>.',
          'incorrectResponse': '<strong>INCORRECT! The answer is C.</strong> Look up your broker’s contact information, or log into your broker’s website. The email you received could be from a bad actor, so you shouldn’t automatically trust the contact information it contains. You don’t want to ignore an email either, but think before clicking on links or providing personal information, even if the email looks official. For more information, check out <a href="https://investor.gov/additional-resources/news-alerts/alerts-bulletins/updated-investor-bulletin-protecting-your-online" target="_blank">Investor Bulletin: Protecting Your Online Investment Accounts From Fraud</a>.'
        },
        {
          'q': 'You feel like you can’t go anywhere without your smart phone. What should you do to protect information on your most prized mobile device?',
          'options': [
            'Get a killer ringtone so you know when your bestie is calling.',
            'Enable remote location and device wiping apps.',
            'Pick the right filter for your selfies, because, like, you can’t even!',
            'Stop the group texts already!'
          ],
          'correctIndex': 1,
          'correctResponse': '<strong>CORRECT!</strong> If you lose your phone you want to be able to locate the lost or stolen device and wipe all the data, remotely. Secure your device’s password protection and automatic locking features. If you can, set up biometric safeguards, such as fingerprint or facial recognition. Make sure anti-virus and anti-malware protection is updated on your mobile devices, and automate your devices’ software updates. Turn off the automatic Wi-Fi settings  to protect yourself from security risks in public settings. Unauthorized access to your smartphone could allow someone to get more than your photos, they could gain access to your online investment accounts. For more information, check out <a href="https://investor.gov/additional-resources/news-alerts/alerts-bulletins/updated-investor-bulletin-protecting-your-online" target="_blank">Investor Bulletin: Protecting Your Online Investment Accounts From Fraud</a>.',
          'incorrectResponse': '<strong>INCORRECT! The answer is B.</strong> If you lose your phone you want to be able to locate the lost or stolen device and wipe all the data, remotely. Secure your device’s password protection and automatic locking features. If you can, set up biometric safeguards, such as fingerprint or facial recognition. Make sure anti-virus and anti-malware protection is updated on your mobile devices, and automate your devices’ software updates. Turn off the automatic Wi-Fi settings  to protect yourself from security risks in public settings. Unauthorized access to your smartphone could allow someone to get more than your photos, they could gain access to your online investment accounts. For more information, check out <a href="https://investor.gov/additional-resources/news-alerts/alerts-bulletins/updated-investor-bulletin-protecting-your-online" target="_blank">Investor Bulletin: Protecting Your Online Investment Accounts From Fraud</a>.'
        },
        {
          'q': 'You want to join the BlingBlingMoney1511 Wi-Fi network in an area coffee shop. What precautionary steps should you take?',
          'options': [
            'Make sure your name is properly spelled on your cup.',
            'If someone looks at you, cover your computer screen and tell them to stop looking at you. The nerve.',
            'Interrupt a couple’s conversation to ask them for the Wi-Fi password. Interrupt them again to ask if it’s case-sensitive.',
            'Make sure the settings on your computer and mobile devices will not automatically connect to any available Wi-Fi connection. This will help protect you from security risks in public spaces.'
          ],
          'correctIndex': 3,
          'correctResponse': '<strong>CORRECT!</strong> Always be mindful of the risks of using shared Internet capabilities. Ensure you use only SSL-secured sites and minimize transactions involving sensitive or personally identifiable information. You want to do all of this and before you even hop on that Wi-Fi network, make sure your computer or mobile device is secure and has current software updates, anti-virus software and a firewall enabled. Be careful with your home Wi-Fi too. For more information, check out <a href="https://investor.gov/additional-resources/news-alerts/alerts-bulletins/updated-investor-bulletin-protecting-your-online" target="_blank">Investor Bulletin: Protecting Your Online Investment Accounts From Fraud</a>.',
          'incorrectResponse': '<strong>INCORRECT! The answer is D.</strong> Always be mindful of the risks of using shared Internet capabilities. Ensure you use only SSL-secured sites and minimize transactions involving sensitive or personally identifiable information. You want to do all of this and before you even hop on that Wi-Fi network, make sure your computer or mobile device is secure and has current software updates, anti-virus software and a firewall enabled. Be careful with your home Wi-Fi too. For more information, check out <a href="https://investor.gov/additional-resources/news-alerts/alerts-bulletins/updated-investor-bulletin-protecting-your-online" target="_blank">Investor Bulletin: Protecting Your Online Investment Accounts From Fraud</a>.'
        },
        {
          'q': 'You detect unauthorized access to your investment account, what should you consider doing first?',
          'options': [
            'Close the account.',
            'Use your social media accounts to complain, #whatthehack?',
            'Tell yourself it’s only money.',
            'Rethink this whole internet thing.'
          ],
          'correctIndex': 0,
          'correctResponse': '<strong>CORRECT!</strong> If you notice an unauthorized access to your account, you may want to contact your investment firm to close the account and move assets to a new account. Consult with your investment firm about the best way to do this. For more information, check out <a href="https://investor.gov/additional-resources/news-alerts/alerts-bulletins/investor-alert-identity-theft-data-breaches-your" target="_blank">Investor Alert: Identity Theft, Data Breaches and your Investment Accounts</a>.',
          'incorrectResponse': '<strong>INCORRECT! The answer is A.</strong> If you notice an unauthorized access to your account, you may want to contact your investment firm to close the account and move assets to a new account. Consult with your investment firm about the best way to do this. For more information, check out <a href="https://investor.gov/additional-resources/news-alerts/alerts-bulletins/investor-alert-identity-theft-data-breaches-your" target="_blank">Investor Alert: Identity Theft, Data Breaches and your Investment Accounts</a>.'
        },
        {
          'q': 'You’ve heard about “the cloud” and have thought about storing your financial information there. What should you consider? (choose the best)',
          'options': [
            'Price. If they charge a lot, it’s probably a rip off.',
            'Whether the service works on clear days or at night.',
            'Confirming that the cloud service provided encrypts all of your information.',
            'The five-day forecast.',
            'Whether your financial information will fall out if it rains.'
          ],
          'correctIndex': 2,
          'correctResponse': '<strong>CORRECT!</strong> You should consider keeping documents containing your sensitive personal financial information (e.g., account numbers, passwords, and PINS) stored offline. If you decide to store any personal financial information in the cloud, carefully research the provider and utilize tools, such as two-step verification and encryption, to protect your financial information. For more information, check out <a href="https://investor.gov/additional-resources/news-alerts/alerts-bulletins/updated-investor-bulletin-protecting-your-online" target="_blank">Investor Bulletin: Protecting Your Online Investment Accounts From Fraud</a>.',
          'incorrectResponse': '<strong>INCORRECT! The answer is C.</strong> You should consider keeping documents containing your sensitive personal financial information (e.g., account numbers, passwords, and PINS) stored offline. If you decide to store any personal financial information in the cloud, carefully research the provider and utilize tools, such as two-step verification and encryption, to protect your financial information. For more information, check out <a href="https://investor.gov/additional-resources/news-alerts/alerts-bulletins/updated-investor-bulletin-protecting-your-online" target="_blank">Investor Bulletin: Protecting Your Online Investment Accounts From Fraud</a>.'
        }
      ]
    });

  
    $("#quiz-restart-btn").html("Quit").attr("rel", "modal:close");

    $("<p>Do you think you’re ready? For more information, check out our <a href='https://investor.gov/additional-resources/news-alerts/alerts-bulletins/investor-alert-identity-theft-data-breaches-your' target='_blank'>Investor Alert</a> on identity theft, data breaches and your investment accounts, and our <a href='https://investor.gov/additional-resources/news-alerts/alerts-bulletins/updated-investor-bulletin-protecting-your-online' target='_blank'>Investor Bulletin</a> on protecting your online investment accounts from fraud.</p>").appendTo("#quiz-results-screen");
   
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