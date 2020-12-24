scroll_bottom = function() {
  if ($('#body-chat').length > 0) {
    $('#body-chat').scrollTop($('#body-chat')[0].scrollHeight);
  }
};

submit_message = function() {
  $('#inputmessage').on('keydown', function(e){
    if(e.keyCode === 13) {
      $('#messagesubmit').click();
      e.target.value = '';
    }
  });
}
submit_button = function() {
  $("#message-form").bind("ajax:complete", function(event,xhr,status){
    $('#inputmessage')[0].value='';
  });
};
document.addEventListener("turbolinks:load", function() {
  scroll_bottom();
  submit_message();
  submit_button();
});