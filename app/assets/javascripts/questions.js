$(function () {
  // show trix answer form
  var show_answer_btn = $('.show-answer-btn');
  show_answer_btn.click(function (event){
    event.preventDefault();
    show_answer_btn.hide();

    $('form#new_answer').show();
  });

  // show trix request form
  var show_request_btn = $('.show-request-btn');
  var report_link = $('.report-link');
  show_request_btn.click(function (event){
    event.preventDefault();
    show_request_btn.hide();
    report_link.hide();

    $('form#new_request').show();
  });

  // submit answer POST
  $('#answer_btn').click(function(e) {
    trixPost($(this), e);
  });

  // submit request for info POST
  $('#request_btn').click(function(e) {
    trixPost($(this), e);
  });

  // submit trix POST
  function trixPost(ele, event) {

    // select proper trix-editor
    var is_answer = ele.attr('id') === "answer_btn";
    var selector = is_answer ? '.answer_form' : '.request_form';
    var trix = document.querySelector(selector + ' trix-editor.formatted_content');

    // get value of response method radio
    var isText = is_answer ? $("#new_answer input[type='radio']:checked").val() : "request";

    // strip formatting
    var plain = trix.editor.getDocument().toString();

    console.log(plain);

    // add body_plain param, post
    var form_ele = is_answer ? $("#new_answer") : $("#new_request");
    var form = form_ele.serializeArray();
    form = form.concat({
      name: "body_plain",
      value: plain
    });

    // make POST request to appropriate path
    var post_path = is_answer ? '/answer' : '/request';
    console.log(form_ele.attr('action') + post_path);
    $.post(form_ele.attr('action') + post_path, form, function (d) {
      if (d.error) {
        alert("There was a problem submitting your question. Please try again later.");
      } else {
        window.location.reload();
      }
    });
  }
});

