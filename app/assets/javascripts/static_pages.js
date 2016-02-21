$(function() {
    var $num_form = $('.box');
    var $submit = $('#submit_btn');
    var $tel = $('#tel');
    var $sending = $('.sending');

    //change "text me" on focus
    $tel.on('focus', function() {
       $submit.css('color', '#e6e8eb');
    });

    $tel.on('blur', function() {
        $submit.css('color', '#600700');
    });

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

        console.log("attempting ajax");
        $.ajax({
          type: 'POST',
          url: 'twilio/send_msg',
          data: num,
          success: function(data) {
            console.log(data);
            // $('.sending').fadeOut('500', function() {});
          }
        });

        $sending.fadeOut(500);
        $sending.fadeIn(500, function() {
            $sending.text("Message sent.");
        });
        // console.log("finished ajax");

    });
});
