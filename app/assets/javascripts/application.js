// =require common

// =require application/newsletter
// =require application/contact

// =require application/modernizr.min.js
// =require application/global.js
// =require application/jquery.nivo.slider.pack.js
// =require application/fancybox/jquery.fancybox-1.3.4.pack.js
// =require application/kohtweets.js
// =require application/mustache.js
// =require application/underscore.js
// =require application/pretty.js

// all pages on the front end of the website have the dynamic account links lazy loaded, this allows for the rest of the page to be cached by varnish, squid etc. and results in extremely fasy user experience
$(document).ready(function(){
  
  Modernizr.load();
  
  $.get('/account_links', function(data) {
  
    if( data.admin ) {
      $('#admin_link').show();
    }
  
    if( data.newsletter ) {
      $('#subscribe_to_newsletter').hide();
      subscribe_to_newsletter
    }
  
    if( data.signed_in ) {
      $('#nav_user').show();
      // dont ask for email or name when prompting for newsletter
      // we use remove, so they are subsequently ignored when checking for required fields
      $('#subscribe_to_newsletter input[type="text"]').remove();
      $('#subscribe_to_newsletter input[type="email"]').remove();
    
    
    } else {
      $('#gn_register').show();
      $('#gn_login').show();
      $('#users_full_name').html(data.full_name);
    }
      
    if( data.connected_to_facebook ) {
      $('.facebook_connect').hide();
    }
      
  }, 'JSON');

 
});