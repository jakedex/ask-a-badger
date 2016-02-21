// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(function() {
    var $num_form = $('.box');
    var $submit = $('#submit_btn');
    var $tel = $('#tel');
    console.log($tel);

    //change "text me" on focus
    $tel.on('focus', function() {
       $submit.css('color', '#e6e8eb');
    });

    // $tel.on('blur', function() {
    //     //$submit.css('color', '#600700');

    //     $submit.fadeOut(500);
    //     $tel.fadeOut(500);

    //     //progress bar
    //     $('.sending').delay(500).fadeIn(500, function() {
    //         var percent = '';
    //         for (var i = 0; i<= 100; i++) {
    //             percent = i + '%';
    //             $('.progress-bar').css('width', percent);
    //         }
    //     });
    // });

    //post on submit
    $num_form.on('submit', function(e) {
        e.preventDefault();
        var num = $tel.serialize();

        $submit.fadeOut(500);
        $tel.fadeOut(500);

        //progress bar
        // $('.sending').delay(500).fadeIn(500, function() {
        //     var percent = '';
        //     for (var i = 0; i<= 100; i++) {
        //         percent = i + '%';
        //         $('.progress-bar').css('width', percent);
        //     }
        // });

        //use $.ajax??
        // $.post('twilio/send', num, function(data) {
        //     //fix to chnage response message
        //     $('#response').html(data);
        // }).fail( function() {
        //     $('#response').html('<p>Sending Failed. Please try again later.</p>');
        // });
        console.log("attempting ajax");
        $.ajax({
          type: 'POST',
          url: 'twilio/send',
          data: num,
          success: function(data) {
            $('.sending').fadeOut('500', function() {

            });
          }
        });

        console.log("finished ajax");

    });
});
