scroll_bottom = function() {
  if ($('#body-chat').length > 0) {
    $('#body-chat').scrollTop($('#body-chat')[0].scrollHeight);
  }
};

submit_message = function() {
  $('#inputmessage').on('keydown', function(e){
    console.log('I am here');
    if(e.keyCode === 13) {
      $('#messagesubmit').click();
      e.target.value = '';
    }
  });
}

document.addEventListener("turbolinks:load", function() {
  scroll_bottom();
  submit_message();
});