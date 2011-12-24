$(document).ready(function(){

  // clicking the flash helper faded the messages out immediately
  $('#flash_helper > div').live('click', function(){
    $(this).remove();
  });

  // animation of the flash notices
  $('#flash_helper > div').delay(2500).fadeOut('fast', function(){
    $(this).remove();
  });

});
