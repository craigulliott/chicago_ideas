$(document).ready(function(){

  // show and hide menu blocks
  $('#content_navigation h2 a.toggle').click(function(e){
    var $ul = $(this).closest('h2').next('ul');
    $ul.stop(true, true);
    if ( $ul.is(":visible") ){
      $ul.slideUp('fast');
    } else {
      $ul.slideDown('fast');
    }
  });
  
  // if the contents of the menu is active, then open it
  $('#content_navigation h2 a.toggle').closest('h2').next('ul').find('li.active').closest('ul').show();
  
  
});