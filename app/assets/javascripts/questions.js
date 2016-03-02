$(function () {
//  console.log($("#answer_btn"));
  
  $('#answer_btn').click(function (event) { //Catch form submit event
    console.log('caught');
//    event.preventDefault(); //Stop it from posting back unless you tell it to
    var everythingIsOkay = true;

    if (everythingIsOkay) {

      // get editor and it's document
      var trix = document.querySelector('trix-editor.formatted_content');
      console.log(trix);
      console.log(trix.editor);

      // get value of response method radio
      var isText = $("#new_answer input[type='radio']:checked").val();
      console.log(isText);

      // strip formatting
      var plain = trix.editor.getDocument().toString();

      console.log(plain);

      // add body_plain param, post
      var form_ele = $("#new_answer");
      var form = form_ele.serializeArray();
      form = form.concat({
        name: "body_plain",
        value: plain
      });

      console.log(form);

      $.post(form_ele.action, form, function (d) {
        if (d.error) {
          alert("There was a problem updating your user details");
        }
      });
    }
  });
});