(function ($, enquire) {


    var createSubMenuButton = function () {
        // var listElementWithSubMenu = $('.global-navigation li.is-expanded'),

        var listElementWithSubMenu = $('li.is-expanded'),
            subMenuButton = $('<span class="sub-menu-button"><a class="sub-menu-link" href="javascript:void(0)"><span class="element-invisible">Expand</span></a></span>');

        listElementWithSubMenu.append(subMenuButton);
        listElementWithSubMenu.removeClass('is-active');

        //Main Menu Expand Toggles Function
        $('.sub-menu-button').on('click', function(e){

            if($(this).parent('li').hasClass('is-active')){
                $(this).parent('li').removeClass('is-active');
                $(this).prev('ul').slideUp();
            }else{
                $(this).parent('li').addClass('is-active');
                $(this).prev('ul').slideDown();
            }

            return false;
        });
    };

    var removeSubMenuButton = function () {

        var subMenuButton = $('.sub-menu-button'),
            subMenu = $('.global-navigation li.is-expanded .menu');

        if(subMenuButton.length) {
            subMenuButton.remove();

            subMenuButton.unbind('click');
            //$('.global-navigation').css('overflow', '');
        }
    };


    $(window).on("load", function (e) {

        enquire.register("screen and (max-width:959px)", {

            match: function () {
                createSubMenuButton();
            },

            unmatch: function () {
                removeSubMenuButton();
            }
        });

    });


})(jQuery, enquire);