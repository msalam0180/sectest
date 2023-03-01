(function ($, enquire) {

    var placeSearchBarInMobileMenu = function () {
        var searchBarElement = $('.global-header-digitalgov-search .body').clone().css('display', 'block').remove(),
            mobileSearchContainer = $('<div class="mobile-menu-search-container"></div>'),
            targetElement = $('.global-navigation');

        if (!$('.mobile-menu-search-container').length) {
            mobileSearchContainer.append(searchBarElement);
            mobileSearchContainer.appendTo(targetElement);

            searchBarElement.find("#global-search").attr("id", "mobile-search");
            searchBarElement.find("#global-search-box").attr("id", "mobile-search-box");

        }
    };

    var removeMobileSearchSection = function () {
        $('.mobile-menu-search-container').remove();
    };


    // Sets the search label display (hide/show) on focus
    var focusSearchLabel = function () {
        /* Show/Hide Global Search label (Desktop Header) */
        $('#global-search-box').click(function() {
            $('#global-search label.overlabel').hide();
        }).focusin(function() {
            $('#global-search label.overlabel').hide();
        }).focusout(function() {
            if ($('#global-search-box').val().length > 0) {
                $('#global-search label.overlabel').hide();
            } else {
                $('#global-search label.overlabel').show();
            }
        });

        /* Show/Hide Mobile Search label (Mobile Nav) */
        $('#mobile-search-box').click(function() {
            $('#mobile-search label.overlabel').hide();
        }).focusin(function() {
            $('#mobile-search label.overlabel').hide();
        }).focusout(function() {
            if ($('#mobile-search-box').val().length > 0) {
              $('#mobile-search label.overlabel').hide();
            } else {
              $('#mobile-search label.overlabel').show();
            }
        }); 
    };


    var openCloseMenu = function () {

        var navbar = $('.global-navigation');
        var menuIcon = $('#mobile-menu-toggle');

        menuIcon.click(function () {

            if (menuIcon.hasClass('is-closed')) {

                menuIcon
                    .removeClass('is-closed')
                    .addClass('is-open')
                    .find("span").html('g');

                navbar.slideDown();
            } else if (menuIcon.hasClass('is-open')) {

                menuIcon
                    .removeClass('is-open')
                    .addClass('is-closed')
                    .find("span").html('q');

                navbar.slideUp();
            }

        }).keypress(function(e){
            var keycode = (e.keyCode ? e.keyCode : e.which);
            if(keycode == '13'){

                if (menuIcon.hasClass('is-closed')) {

                    menuIcon
                        .removeClass('is-closed')
                        .addClass('is-open')
                        .find("span").html('g');

                    navbar.slideDown();
                } else if (menuIcon.hasClass('is-open')) {

                    menuIcon
                        .removeClass('is-open')
                        .addClass('is-closed')
                        .find("span").html('q');

                    navbar.slideUp();
                }

            }
            //Stop the event from propogation to other handlers or at the document level
            e.stopPropagation();
        });
             
    };

    $(document).ready(function () {
        openCloseMenu();
        
        // Insert link for the home page in the first toggle nav area
        $(".mobile-menu > ul#main-menu > li.menu__item:first-child > a.menu__link").attr("href", "/");

    });

    $(window).on("load", function (e) {

        enquire.register("screen and (max-width:959px)", {

            match: function () {
                placeSearchBarInMobileMenu();
            },

            unmatch: function () {
                removeMobileSearchSection();
            }

        });

    });

    var mainMenu = $('#block-secgov-main-menu ul.menu');

    // When window loads and resizes
    $(window).on("load", function (e) {

        // Hide subsequent main menu items after the first child
        $("#main-menu li.is-expanded:not(:first-child)").hide();

        // Calls the search label hide/show and focus function 
        focusSearchLabel();

        // Specify expanded top-level menu classes based on if internal <ul> exists
        $("#section-menu > li").has("ul").addClass("is-expanded expanded").removeClass("is-leaf leaf");
        $("#section-menu > li:first-child").addClass("expanded").removeClass("is-leaf leaf");

        // Mobile/Desktop Display Global (Main) Nav Menu
        // Mobile
        if ($(this).width() < 960) {
            $(".desktop-menu").hide();
            $(".mobile-menu").show();

            // Set/remove the tab ordering per mobile where needed
            $("#mobile-menu-toggle").attr("tabindex", 4);
            $("#mobile-search .usagov-search-autocomplete").removeAttr("tabindex");
            $("#mobile-search .global-search-button").removeAttr("tabindex");
            $("#mobile-search .option-link").removeAttr("tabindex");

            // Destroy superfish plugin on main-navigation
            mainMenu.superfish('destroy');

        // Desktop
        } else {
            $(".mobile-menu").hide();
            $(".desktop-menu").show();

            // Set the tab ordering per desktop where needed
            $("#global-search .usagov-search-autocomplete").attr("tabindex", 4);
            $("#global-search .global-search-button").attr("tabindex", 5);
            $("#global-search .option-link:first").attr("tabindex", 6);
            $("#global-search .option-link:last").attr("tabindex", 7);

            // Initialize superfish plugin on main-navigation
            mainMenu.superfish({
                delay: 650,     // delay on mouseout
                animation: {height: 'show'} // fade-in and slide-down animation
            });
        }

        // Default State (remove 'U.S.' and exchange 'and' for '&')
        $(".mobile-menu > ul#main-menu > li.menu__item:first-child > a.menu__link:contains('U.S. Securities and Exchange Commission')").text("Securities & Exchange Commission");
        // Extra Small Mobile
        if ($(window).width() <= 375) {
            // Remove 'U.S.'
            $(".mobile-menu > ul#main-menu > li.menu__item:first-child > a.menu__link:contains('U.S. Securities & Exchange Commission')").text("Securities & Exchange Commission");
        } else {
            // Back to Default State
            $(".mobile-menu > ul#main-menu > li.menu__item:first-child > a.menu__link").text("U.S. Securities & Exchange Commission");
        }

    }).resize(function() {

        // Calls the search label hide/show and focus function
        focusSearchLabel();

        // Mobile/Desktop Display Global (Main) Nav Menu
        // Mobile
        if ($(this).width() < 960) {
            $(".desktop-menu").hide();
            $(".mobile-menu").show();

            // Set menu toggle based on status, change icon and hide/show navigation
            // Check for menu toggle status and based on status, keep open or closed
            if ($('#mobile-menu-toggle').hasClass('is-open')) {
                $('.global-navigation').show();
                $(this).removeClass('is-closed').addClass('is-open');
                $(this).find("span").html('g');
            } else if ($('#mobile-menu-toggle').hasClass('is-closed')) {
                $('.global-navigation').hide();
                $(this).removeClass('is-open').addClass('is-closed');
                $(this).find("span").html('q');
            }

            // Set/remove the tab ordering per mobile where needed
            $("#mobile-menu-toggle").attr("tabindex", 4);
            $("#mobile-search .usagov-search-autocomplete").removeAttr("tabindex");
            $("#mobile-search .global-search-button").removeAttr("tabindex");
            $("#mobile-search .option-link").removeAttr("tabindex");

            // Destroy superfish plugin on main-navigation
            mainMenu.superfish('destroy');


        // Desktop
        } else {
            $(".mobile-menu").hide();
            $(".desktop-menu").show();
            
            // Set menu toggle to close, change icon and show global navigation
            $('.global-navigation').show();
            $('#mobile-menu-toggle').find('span').html('q');
            $('#mobile-menu-toggle').removeClass('is-open').addClass('is-closed');

            // Set the tab ordering per desktop where needed
            $("#global-search .usagov-search-autocomplete").attr("tabindex", 4);
            $("#global-search .global-search-button").attr("tabindex", 5);
            $("#global-search .option-link:first-child").attr("tabindex", 6);
            $("#global-search .option-link:last-child").attr("tabindex", 7);

            // Initialize superfish plugin on main-navigation
            mainMenu.superfish({
                delay: 650,     // delay on mouseout
                animation: {height: 'show'} // fade-in and slide-down animation
            });
        }

        // Default State (remove 'U.S.' and exchange 'and' for '&')
        $(".mobile-menu > ul#main-menu > li.menu__item:first-child > a.menu__link:contains('U.S. Securities and Exchange Commission')").text("Securities & Exchange Commission");
        // Extra Small Mobile
        if ($(window).width() <= 375) {
            // Remove 'U.S.'
            $(".mobile-menu > ul#main-menu > li.menu__item:first-child > a.menu__link:contains('U.S. Securities & Exchange Commission')").text("Securities & Exchange Commission");
        } else {
            // Back to Default State
            $(".mobile-menu > ul#main-menu > li.menu__item:first-child > a.menu__link").text("U.S. Securities & Exchange Commission");
        }

    });



})(jQuery, enquire);
