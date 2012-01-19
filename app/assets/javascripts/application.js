// =require common

// =require application/global.js
// =require application/modernizr-1.7.min.js
// =require application/jquery.nivo.slider.pack.js
// =require application/fancybox/jquery.fancybox-1.3.4.pack.js

// all pages on the front end of the website have the dynamic account links lazy loaded, this allows for the rest of the page to be cached by varnish, squid etc. and results in extremely fasy user experience
$(document).ready(function(){
  
  $.get('/account_links', function(data) {
    log(data)
  }, 'JSON');
  
});