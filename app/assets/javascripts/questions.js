$(document).ready(function () {
  $("#new_answer").submit(function (event) { //Catch form submit event
    event.preventDefault(); //Stop it from posting back unless you tell it to
    var everythingIsOkay = true;

    if (everythingIsOkay) {
      
      // get editor and it's document
      var trix = document.querySelector('trix-editor.formatted_content');
      console.log(trix);
      console.log(trix.editor);
//      var doc = element.editor.getDocument();
      
      // get value of response method radio
      var isText = $("#new_answer input[type='radio']:checked").val();
      console.log(isText);
      
      // strip formatting if text
      if (isText === 'text') {
        var plain = trix.editor.getDocument().toString();
      }
      
      console.log(plain);

//      document.forms["new_answer"].submit(); //Go ahead and postback
    }
  });
});