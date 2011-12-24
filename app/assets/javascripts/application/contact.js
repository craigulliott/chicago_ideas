$(document).ready(function(){

  // dont submit the contact form unless all the fields have been used
  // -------------------------------------------------------------------
  $('body#application_page.contact form.contact').submit(function(){
    
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
    
    $(this).hide();
    $('#thank_you').show();
  
  });

});

