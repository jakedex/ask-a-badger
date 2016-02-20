'use strict';

$(function() {
    var $submit = $('#submit');
    var $tel = $('#tel');
    
    //change "text me" on focus
    $tel.on('focus', function() {
       $submit.css('color', '#e6e8eb');
    });
    
    $tel.on('blur', function() {
        //$submit.css('color', '#600700');
        
        $submit.fadeOut(500);
        $tel.fadeOut(500);
            
        //progress bar
        $('.sending').delay(500).fadeIn(500, function() {
            var percent = '';
            for (var i = 0; i<= 100; i++) {
                percent = i + '%';
                $('.progress-bar').css('width', percent);
            }
        });
    });
    
    //post on submit
    $tel.on('submit', function(e) {
        e.preventDefault();
        var num = $tel.serialize();
        
        $submit.fadeOut(500);
        $tel.fadeOut(500);
            
        //progress bar
        $('.sending').delay(500).fadeIn(500, function() {
            var percent = '';
            for (var i = 0; i<= 100; i++) {
                percent = i + '%';
                $('.progress-bar').css('width', percent);
            }
        });
        
        //use $.ajax??
        $.post('sendnotifications.php', num, function(data) {
            
            
            //fix to chnage response message
            $('#response').html(data);
        }).fail( function() {
            $('#response').html('<p>Sending Failed. Please try again later.</p>');
        });
        
    });
});