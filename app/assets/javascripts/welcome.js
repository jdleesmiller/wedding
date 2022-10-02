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
})