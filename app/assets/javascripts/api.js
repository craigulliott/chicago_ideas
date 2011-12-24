// =require common

$(document).ready(function(){

  // submitting a test form
  $('#documentation_page.documentation .controller .action a.submit').click(function(e){
    var $form = $(this).closest('form');
    
    var missing_some_fields = false;
    $form.find('li.required input').each(function(i,n){
      // add the 'required' class to required inputs without values
      $(this).addClass('error'); 
      if( $(this).val() ){
        $(this).removeClass('error'); 
      }else{
        missing_some_fields = true;
      }
    });
    
    // prevent submitting the form if there are empty required fields
    if( missing_some_fields ){
      return false;
    }
    
    // rails adds these elementa, and it looks confusing when posted during an API test. so remove them
    $form.find('input[name="authenticity_token"]').remove(); 
    $form.find('input[name="utf8"]').remove(); 

    // we are going to modify the action, so we need to keep a clean copy of it
    if ( !$form.attr('original_action') ){
      $form.attr('original_action', $form.attr('action'));
    }
    
    // if there is any placeholders in the path, then they need to be replaced with coresponding values from the form
    // we also remove these form elements until we have finished posting, because we dont want to show them as actual 
    // parameters and confuse the developer
    $form.attr('action', $form.attr('original_action'));
    var path_params = $form.attr('action').match(/\~[a-zA-Z0-9_-]+\~/g);
    var element_store = [];
    for (i in path_params) {
      path_token = path_params[i].replace(/\~/,'').replace(/\~/,'');
      // the coresponding element on the dom
      var $elt = $form.find('input[name="'+path_token+'"]')
      // so we can add it again later
      $elt.belongs_to = $elt.parent();
      // take it out, without destroying it
      $elt.detach();
      // update the path with these variables
      $form.attr('action', $form.attr('action').replace("~"+path_token+"~", $elt.val()))
      // remove the element, but keep it for later (we are going to add it back after the form submit)
      element_store.push($elt);
    }
    
    // submit the form
    $form.submit(); 

    // put the form elements used for building the path, back onto the form
    while( restored_element = element_store.pop() ){
      restored_element.insertAfter($(restored_element.belongs_to).find('label'));
    }
    // as this is a link, we stop page navigation
    e.preventDefault();
  
  });
  
});