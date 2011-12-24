$(document).ready(function(){
  
  // ------------------- Searching ------------------- 
  
  // focus on the first input box (or select box), shows all the others
  $('form.searchable :input').live('focus', function(){
    $(this).closest('form').find('.search-option:hidden').fadeIn('fast');
    $(this).closest('form').find('.actions:hidden').fadeIn('fast');
  });

  // cancel hides all but the first control
  $('form.searchable a.cancel').live('click', function(){
    $(this).closest('form').find('.search-option:gt(0)').fadeOut('fast');
    $(this).closest('form').find('.actions').fadeOut('fast');
    return false;
  });
    
});