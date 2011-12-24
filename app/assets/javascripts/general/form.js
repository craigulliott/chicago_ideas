$(document).ready(function(){

  // we replace these checkboxes with nicer looking images of checkboxes
  $('.formtastic li.check_boxes input[type="checkbox"]').ezMark();
  $('.formtastic li.boolean input[type="checkbox"]').ezMark();
  
  // all links can display messages
  $('a').live('ajax:success', function(data, status){
    // if we recieved a message then display it
    if ( status.notice ) {
      Utility.flash_notice(status.notice);
    }
  });

  // all links can cause a reload
  $('a').live('ajax:success', function(data, status){
    // the reload can be initiated from the backend, or is the link is of type reload, and not a dialog
    if ( status.reload || ( $(this).is('.reload') && !$(this).is('.dialog') ) ){
      window.location.reload();
    }
  });

  // a simple generic way to lock forms, or more commonly prevent submitting forms twice
  $('form').submit(function(){
    if ( $(this).is('.locked') ) {
      return false;
    }
  });

  // some inputs only accept numbers
  $('input.numeric').live('keydown', function(e){
    return Utility.allow_number_key(e);
  })

  // these remote links open their content in a dialog
  $('a.dialog').live('ajax:loading', function(){
    // show a loading graphic
    Utility.open_dialog($('#dialog_loading').html());

  }).live('ajax:success', function(data, status){
    
    var $dialog_contents = $(status.html);
    
    // if this link requires the page reloads on a successful response from interacting with this dialog, then we must pass this state onto the dialog 
    if ( $(this).is('.reload') ) {
      $dialog_contents.filter('form').addClass('reload');
    }
    
    // put the remote content in the dialog
    Utility.open_dialog($dialog_contents);
  
    // put focus on the first input (unless its a datepicker - because a datepicker will open when it receives focus)
    $('#dialog :input:visible:first:not(.ui-datepicker):not(.ui-timepicker)').focus();
  
    // pressing the escape key should close the dialog
    $(document).unbind('keydown.dialog').bind('keydown.dialog',function (e) {
      if ( e.which == 27 ) {
        Utility.close_dialog();
      }
    });

  });

  // close buttons always close the dialog
  $('#dialog a.close').live('click', function(e){
    Utility.close_dialog();
    e.preventDefault();
  });

  // these remote links delete their table row on success
  $('a.row-delete').live('ajax:success', function(data, status){
    if ( status.status == "ok" ) {
      $(data.currentTarget).closest('tr').fadeOut('slow', function(){
        $(this).remove();
      });
    }
  });

  // delete and undelete links effect the class on their table row
  $('a.delete').live('ajax:success', function(data, status){
    if ( status.status == "ok" ) {
      $(data.currentTarget).closest('tr').addClass('deleted');
    }
  });
  $('a.undelete').live('ajax:success', function(data, status){
    if ( status.status == "ok" ) {
      $(data.currentTarget).closest('tr').removeClass('deleted');
    }
  });

  
  // all remote links have some blocking and animation to help users understand them
  $('a').live('ajax:before', function(data, status){
    $(this).addClass('locked');
  }).live('ajax:success', function(){
    $(this).removeClass('locked');
  }).live('ajax:complete', function(){
    $(this).removeClass('locked');
  }).live('ajax:failure', function(){
    $(this).removeClass('locked');
  });

  // these links can trigger "toggle" functionality
  $('a.toggle').live('ajax:success', function(data, status){
    $(data.currentTarget).parent().closest('.toggle').find('a').toggle();
  });

  // these links close the dialog
  $('#dialog a.cancel').live('click', function(e){
    // remove the listener for the escape key
    $(document).unbind('keydown.dialog');
    // close the dialog
    Utility.close_dialog();
    // dont navigate the browser
    e.preventDefault();
  });

  // inputs with labels as default values
  $('input.click_clear')
  .focus(function(){
    var $this = $(this);
    if ( $this.val() == $this.attr('title') ) {
      $this.removeClass("click_clear_active").val('');
    }
  })
  .blur(function(){
    var $this = $(this);
    if ( $this.val() == '' ) {
      $this.addClass('click_clear_active').val($this.attr('title'));
    }
  })
  .blur();
  
  // scroll to errors in forms
  if ( $first_error = $('form.formtastic p.inline-errors:first').length > 0 ){
    $.scrollTo($('form.formtastic p.inline-errors:first').closest('li'));
  }

  // so we can apply styles to the input which is currently in focus
  $(':input').live('focus', function(){
    $(this).addClass('active').closest('li').addClass('active');
  }).live('blur', function(){
    $(this).removeClass('active').closest('li').removeClass('active');
  });

  // remote forms
  $('form').live('ajax:loading', function(){
    Forms.form_loading($(this));

  }).live('ajax:failure', function(xhr, status, error){
    log(xhr);
    log(status);
    log(error);

  }).live('ajax:success', function(data, status){
    Forms.form_success($(this), status);
  
  });

  //activate the forms
  Forms.create_custom_controls();

});


Forms = {

  // when we dyanmically create iframes, this ensures they have unique id's
  unique_form_iframe : 0,
  
  // when a form is loading
  form_loading: function(form){
    
    // we change the label on the submit button (and store the default label, so we can rest it after the post)
    var $btn = $(form).find('input[type="submit"]');
    $(form).attr('post_label', $btn.val());
    $btn.val('Please Wait...');

    // we add a submitting class to the form, this shows the loader and is used to prevent another post
    $(form).addClass('submitting');
    
  },
  
  
  // when a form submit has completed
  form_success: function(form, status){
    
    // if rails sent back a redirect instruction, then we redirect
    if ( status.status == "redirect" ){
      window.location = status.to;
      return;
    } 
  
    // if we recieved a message then display it
    if ( status.notice ){
      Utility.flash_notice(status.notice);
    }
  
    // if we created or added an object then look for a table to update
    if ( status.created ){
      var $new_row = $(status.html).effect("pulsate", { times:3 }, 500);
      // insert the HTML
      $('#'+status.created.types+' tr:first').after($new_row);
    }
    if ( status.updated ){
      var selector = '#'+status.updated.types+' tr['+status.updated.type+'="'+status.updated.id+'"]';
      var $new_row = $(status.html).effect("pulsate", { times:3 }, 500);
      // insert the HTML
      $(selector).replaceWith($new_row);
    }
  
    // if there was an error, then re-display the html (if there is html to display)
    if ( status.status == "error" && status.html ){
      
      // if this is a form with an instruction to reload, pass that instruction to the new form
      var $dialog_contents = $(status.html);

      // if this link requires the page reloads on a successful response from interacting with this dialog, then we must pass this state onto the dialog 
      if ( $(form).is('.reload') ) {
        $dialog_contents.filter('form').addClass('reload');
      }
      
      $(form).replaceWith($dialog_contents);
      // if there are controls which havent been activated, this will activate them
      Forms.create_custom_controls();
      return;
    
    } else if ( status.status == "error" ){
      // if there is no html, then close the dialog and assume there was a message
      Utility.close_dialog();
      return;
    }
  
    // unlock the form
    $(form).removeClass('submitting');
    // and restore the default label
    var $btn = $(form).find('input[type="submit"]');
    $btn.val($(form).attr('post_label'));

    // was this dialog instructed to reload after a successful for submission
    if ( $(form).is('.reload') ){
      window.location.reload();
    }

    // if it was a success, and we are not redirecting, then close the dialog (if we are in one)
    if ( status.status == "ok" ) {
      Utility.close_dialog();
      return;
    }
    
  },
  
  // Nested Model Form
  // http://railscasts.com/episodes/197-nested-model-form-part-2
  remove_fields: function(link) {
    $(link).prev("input[type=hidden]").val("1");
    $(link).closest("fieldset").fadeOut();
  },

  // Nested Model Form
  // http://railscasts.com/episodes/197-nested-model-form-part-2
  add_fields :function(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g")
    var $new_elt = $(content.replace(regexp, new_id));
    $new_elt.fadeIn().insertAfter($(link));
    $new_elt.find(':input:first').focus();
  },
  
  // the following custom controls are wrapped in this method 
  // so we can create them at page load and after opening a dialog
  create_custom_controls: function(){
    
    // date pickers
    $(".datepicker:not(.hasDatepicker)").datepicker({
      dateFormat:'yy-mm-dd', 
      ampm: true,
      changeMonth: true,
      changeYear: true
    });

    // time pickers
    $(".timepicker:not(.hasDatepicker)").timepicker({
      ampm: true,
    });

    // date and time pickers
    $(".datetimepicker:not(.hasDatepicker)").datetimepicker({
      dateFormat:'yy-mm-dd', 
      ampm: true,
      changeMonth: true,
      changeYear: true
    });
    
    // sexy looking check boxes and radio buttons
    $('input[type="radio"]:not(.control-activated), input[type="checkbox"]:not(.control-activated)').addClass('control-activated').ezMark();

    // "live" is not reliable on forms
    $('form').submit(function(){
      var $form = $(this);
      
      // we dont submit forms that are already in progress
      if ( $form.is('.submitting') ){
        // prevent the form submit
        return false;
      }
      
      // does this form post to an iframe
      if ( $form.attr('target') ){
        
        // the same loading event that occurs with the non iframe forms
        Forms.form_loading($form);
        // when loading of the iframe has finished, grab the contents out of the iframe (we put the encoded JSON into a textarea because its a more reliable way to transmit it)
        $('iframe[name="iframe_upload"]').load(function(){
          // get the JSON resut from inside the iFrame
          var result = $.parseJSON(
            $('iframe[name="iframe_upload"]').contents().find('body textarea').val()
          )
          
          // the same 'completed' event that occurs with the non iframe forms
          Forms.form_success($form, result);

        });
        
      }

    });
    
  }
}
