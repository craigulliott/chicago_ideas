Utility = {

  flash_notice: function(message){
    var $new_message = $('<div>'+message+'</div>');
    $new_message.delay(2500).fadeOut('fast', function(){
      $(this).remove();
    });
    $('#flash_helper').append($new_message)
  },

  open_dialog: function(html, width) {
    // calculate the top position of the box
    var t = $(window).scrollTop() + 90;
    $('#dialog .dialog_container').css('top', t + 'px');
    // print html
    $contents = $('#dialog .dialog_contents');
    if( ! width ) width = 640;
    $contents.css('width', width+'px').html(html);
    $('#dialog').show();
    // if there are controls which havent been activated, this will activate them
    Forms.create_custom_controls();
  },

  close_dialog: function() {
    $('#dialog').hide();
    $('#dialog .dialog_contents').html('');
  },

  // returns true if the keyCode associated with an event is a number
  // this is used to allow only numbers to be entered into a input box
  allow_number_key: function(evt) {
    // number keys, arrow keys and functional keys like delete tab etc
    return ( (evt.which < 32) || evt.which == 46 || (evt.which > 36 && evt.which < 41) || (evt.which > 95 && evt.which < 106) || (evt.which > 47 && evt.which < 58) )
  },

  // a bit of fun
  konami: function(){
    $('body').append($('<img src="/images/logo.png">').clone().css({
      position:'absolute',
      left:Math.abs(Math.random()*$(document).width()-110)+'px',
      top:Math.abs(Math.random()*$(document).height()-114)+'px',
      zIndex:99999
    }));
  },

  // track an arbitrary event to google analytics
  event_track: function(value){
    track_url = '/dynamic_event/' + value;
    _gaq.push(['_trackPageview', track_url])
    // we dont use the log() method for this as in the past we have logged
    // that method to google which would greate an infinite loop
    if ( window.console && window.console.log ){
      window.console.log('tracking the event: '+track_url);
    }
  }

};


// most functions we name space, but this one is just too common
function log(message) {
  if ( window.console && window.console.log ){
    window.console.log(message);
  }
};

// konami
if ( window.addEventListener ) {
  var kkeys = [], konami = "38,38,40,40,37,39,37,39,66,65";
  window.addEventListener("keydown.konami", function(e){
    kkeys.push( e.keyCode );
    if ( kkeys.toString().indexOf( konami ) >= 0 ){
      setInterval('Utility.konami();', 30);
    }
  }, true);
};

// make some conditional jqiery code more readable with an exists function
jQuery.fn.exists = function(){ 
  return this.length>0;
}
