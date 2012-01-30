$(document).ready(function(){

  // dont submit the contact form unless all the fields have been used
  // -------------------------------------------------------------------
  $('form#subscribe_to_newsletter').submit(function(){
    
    $(this).find(':input').closest('li').removeClass('error');
    $missing = [];
    
    $(this).find('.required').each(function(i){
      if ($(this).find(':input:[value=""]')){
        $missing.push($(this).find(':input:[value=""]').closest('li').addClass('error'));
      }
    });

    if( $(this).find('.error').length > 0 ){
      return false;
    }
    
    $(this).addClass('locked').find('input.submit').attr('value','Please wait..');
    Utility.flash_notice('Please Wait....');

  }).bind('ajax:success', function(data, status, xhr){
    
    // always display notices it there are any
    if( status.notice ){
      Utility.flash_notice(status.notice);
    }
    
    // update the form with any errors we may have recieved
    if( status.html ){
      $(this).html($(status.html).find('form').html)
    } 
    // else it was a success, hide newsletter signups
    else {
      $('#subscribe_to_newsletter').fadeOut();
    }

  });

});

