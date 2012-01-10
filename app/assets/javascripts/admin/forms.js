$(document).ready(function(){

  // show and hide form section blocks
  $('body.admin form.formtastic fieldset.toggle legend span').live('click', function(e){
    var $ol = $(this).closest('fieldset.toggle').find('> ol');
    $ol.stop(true, true);
    if ( $ol.is(":visible") ){
      $ol.slideUp('fast');
    } else {
      $ol.slideDown('fast');
    }
  });
  
});