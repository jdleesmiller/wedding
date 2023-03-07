// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function () {
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();

            document.querySelector(this.getAttribute('href')).scrollIntoView({
                behavior: 'smooth'
            });
        });
    });
    $('.navbar-collapse a').click(function (e) {
        $('.navbar-collapse').collapse('toggle');
    });

    $(function () {
        setInterval(function () {
            $('.scroll').fadeIn(1000).delay(600).fadeOut(1000).delay(50).fadeIn(1000);
        }, 2000);
    });

    $( "#schedule tr td:nth-child(2)" ).addClass( "text-right" );

    // Define selector for selecting
    // anchor links with the hash
    let anchorSelector = 'a[href^="#"]';

    $(anchorSelector).on('click', function (e) {

        // Prevent scrolling if the
        // hash value is blank
        e.preventDefault();

        // Get the destination to scroll to
        // using the hash property
        let destination = $(this.hash);

        // Get the position of the destination
        // using the coordinates returned by
        // offset() method and subtracting 50px
        // from it.
        let scrollPosition
            = destination.offset().top - 50;

        // Specify animation duration
        let animationDuration = 500;

        // Animate the html/body with
        // the scrollTop() method
        $('html, body').animate({
            scrollTop: scrollPosition
        }, animationDuration);
    });
})