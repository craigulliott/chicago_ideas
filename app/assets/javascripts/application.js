// =require common

// =require application/contact

// all pages on the front end of the website have the dynamic account links lazy loaded, this allows for the rest of the page to be cached by varnish, squid etc. and results in extremely fasy user experience
$(document).ready(function(){
  $('#account_links').load('/account_links');
});