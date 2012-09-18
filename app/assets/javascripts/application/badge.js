$(document).ready(function(){

  // dont submit the build-a-badge form unless all the fields have been used
  // -------------------------------------------------------------------
  $('body#application_page.badge form.badge').live('submit', function(){
    
    $(this).find(':input').closest('li').removeClass('error');
    var missing = [];
    
    $(this).find('.required').each(function(){
      var $input = $(this).find(':input')
      var val = $.trim($input.val());
      if (val == '') {
        
        missing.push($input.closest('li').addClass('error'));
        
        var inspirations = [$('#badge_inspiration_1'), $('#badge_inspiration_2'), $('#badge_inspiration_3')];
        for (var i = 0; i < inspirations.length; i++) {
          var $inspiration = inspirations[i];
          if($.trim($inspiration.val()).length > 20) {
            missing.push($inspiration.closest('li').addClass('error'));
          }
        }
        
        
      }
    });

    if( $(this).find('.error').length > 0 ){
      return false;
    }
    
    //$(this).addClass('locked').find('input.submit').attr('value','Please wait..');
    //Utility.flash_notice('Please Wait....');
    
  });

});

