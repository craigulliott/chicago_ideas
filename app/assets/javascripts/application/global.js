/*
easing
*/
jQuery.easing['jswing']=jQuery.easing['swing'];jQuery.extend(jQuery.easing,{def:'easeOutQuad',swing:function(x,t,b,c,d){return jQuery.easing[jQuery.easing.def](x,t,b,c,d)},easeInQuad:function(x,t,b,c,d){return c*(t/=d)*t+b},easeOutQuad:function(x,t,b,c,d){return-c*(t/=d)*(t-2)+b},easeInOutQuad:function(x,t,b,c,d){if((t/=d/2)<1)return c/2*t*t+b;return-c/2*((--t)*(t-2)-1)+b},easeInCubic:function(x,t,b,c,d){return c*(t/=d)*t*t+b},easeOutCubic:function(x,t,b,c,d){return c*((t=t/d-1)*t*t+1)+b},easeInOutCubic:function(x,t,b,c,d){if((t/=d/2)<1)return c/2*t*t*t+b;return c/2*((t-=2)*t*t+2)+b},easeInQuart:function(x,t,b,c,d){return c*(t/=d)*t*t*t+b},easeOutQuart:function(x,t,b,c,d){return-c*((t=t/d-1)*t*t*t-1)+b},easeInOutQuart:function(x,t,b,c,d){if((t/=d/2)<1)return c/2*t*t*t*t+b;return-c/2*((t-=2)*t*t*t-2)+b},easeInQuint:function(x,t,b,c,d){return c*(t/=d)*t*t*t*t+b},easeOutQuint:function(x,t,b,c,d){return c*((t=t/d-1)*t*t*t*t+1)+b},easeInOutQuint:function(x,t,b,c,d){if((t/=d/2)<1)return c/2*t*t*t*t*t+b;return c/2*((t-=2)*t*t*t*t+2)+b},easeInSine:function(x,t,b,c,d){return-c*Math.cos(t/d*(Math.PI/2))+c+b},easeOutSine:function(x,t,b,c,d){return c*Math.sin(t/d*(Math.PI/2))+b},easeInOutSine:function(x,t,b,c,d){return-c/2*(Math.cos(Math.PI*t/d)-1)+b},easeInExpo:function(x,t,b,c,d){return(t==0)?b:c*Math.pow(2,10*(t/d-1))+b},easeOutExpo:function(x,t,b,c,d){return(t==d)?b+c:c*(-Math.pow(2,-10*t/d)+1)+b},easeInOutExpo:function(x,t,b,c,d){if(t==0)return b;if(t==d)return b+c;if((t/=d/2)<1)return c/2*Math.pow(2,10*(t-1))+b;return c/2*(-Math.pow(2,-10*--t)+2)+b},easeInCirc:function(x,t,b,c,d){return-c*(Math.sqrt(1-(t/=d)*t)-1)+b},easeOutCirc:function(x,t,b,c,d){return c*Math.sqrt(1-(t=t/d-1)*t)+b},easeInOutCirc:function(x,t,b,c,d){if((t/=d/2)<1)return-c/2*(Math.sqrt(1-t*t)-1)+b;return c/2*(Math.sqrt(1-(t-=2)*t)+1)+b},easeInElastic:function(x,t,b,c,d){var s=1.70158;var p=0;var a=c;if(t==0)return b;if((t/=d)==1)return b+c;if(!p)p=d*.3;if(a<Math.abs(c)){a=c;var s=p/4}else var s=p/(2*Math.PI)*Math.asin(c/a);return-(a*Math.pow(2,10*(t-=1))*Math.sin((t*d-s)*(2*Math.PI)/p))+b},easeOutElastic:function(x,t,b,c,d){var s=1.70158;var p=0;var a=c;if(t==0)return b;if((t/=d)==1)return b+c;if(!p)p=d*.3;if(a<Math.abs(c)){a=c;var s=p/4}else var s=p/(2*Math.PI)*Math.asin(c/a);return a*Math.pow(2,-10*t)*Math.sin((t*d-s)*(2*Math.PI)/p)+c+b},easeInOutElastic:function(x,t,b,c,d){var s=1.70158;var p=0;var a=c;if(t==0)return b;if((t/=d/2)==2)return b+c;if(!p)p=d*(.3*1.5);if(a<Math.abs(c)){a=c;var s=p/4}else var s=p/(2*Math.PI)*Math.asin(c/a);if(t<1)return-.5*(a*Math.pow(2,10*(t-=1))*Math.sin((t*d-s)*(2*Math.PI)/p))+b;return a*Math.pow(2,-10*(t-=1))*Math.sin((t*d-s)*(2*Math.PI)/p)*.5+c+b},easeInBack:function(x,t,b,c,d,s){if(s==undefined)s=1.70158;return c*(t/=d)*t*((s+1)*t-s)+b},easeOutBack:function(x,t,b,c,d,s){if(s==undefined)s=1.70158;return c*((t=t/d-1)*t*((s+1)*t+s)+1)+b},easeInOutBack:function(x,t,b,c,d,s){if(s==undefined)s=1.70158;if((t/=d/2)<1)return c/2*(t*t*(((s*=(1.525))+1)*t-s))+b;return c/2*((t-=2)*t*(((s*=(1.525))+1)*t+s)+2)+b},easeInBounce:function(x,t,b,c,d){return c-jQuery.easing.easeOutBounce(x,d-t,0,c,d)+b},easeOutBounce:function(x,t,b,c,d){if((t/=d)<(1/2.75)){return c*(7.5625*t*t)+b}else if(t<(2/2.75)){return c*(7.5625*(t-=(1.5/2.75))*t+.75)+b}else if(t<(2.5/2.75)){return c*(7.5625*(t-=(2.25/2.75))*t+.9375)+b}else{return c*(7.5625*(t-=(2.625/2.75))*t+.984375)+b}},easeInOutBounce:function(x,t,b,c,d){if(t<d/2)return jQuery.easing.easeInBounce(x,t*2,0,c,d)*.5+b;return jQuery.easing.easeOutBounce(x,t*2-d,0,c,d)*.5+c*.5+b}});


// Twitter
!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");

// Google +
(function() {
   var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
   po.src = 'https://apis.google.com/js/plusone.js';
   var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
 })();
 
 

var nextBanner = function () {
  if ( $('a.b_thumb_active').parent().next().find('a.b_thumb').length > 0 ) {
    $('a.b_thumb_active').parent().next().find('a.b_thumb').click();
  } else {
    $('#banner_nav li:first-child a').click();
  }
}


$(document).ready(function() {
  
  
  
  $('.explore_').bind('hover', function(e) {
    $('.explore_dropdown').fadeToggle('fast');
  });
  $('.close_explore_btn').bind('click', function(e) {
    $('.explore_dropdown').fadeToggle('fast');
  });
  
  /************************************************************************************
   **    
   **    Sliders and Image Galleries
   **
  ************************************************************************************/
  
  $('.slider, .talk_gallery').nivoSlider({
    effect: 'fade', // Specify sets like: 'fold,fade,sliceDown'
    animSpeed: 500, // Slide transition speed
    pauseTime: 5000, // How long each slide will show
    directionNav: false, // Next & Prev navigation
    controlNav: true, // 1,2,3... navigation
    keyboardNav: false, // Use left & right arrows
    pauseOnHover: false, // Stop animation while hovering
    manualAdvance: false, // Force manual transitions
    randomStart: false, // Start on a random slide
    afterLoad: function(){
      //var controlCount = $(this).children().find('.nivo-controlNav a').length();
      var newWidth = ($('.nivo-controlNav a').length) * 20;
      $('.nivo-controlNav').css({
        'width' : newWidth,
        'left' : '50%',
        'margin-left' : -1 * (newWidth / 2)
      })
    }
  });

    
  $('#sponsors ul').nivoSlider({
    effect: 'fade', // Specify sets like: 'fold,fade,sliceDown'
    animSpeed: 500, // Slide transition speed
    pauseTime: 5000, // How long each slide will show
    directionNav: false, // Next & Prev navigation
    controlNav: false, // 1,2,3... navigation
    keyboardNav: false, // Use left & right arrows
    pauseOnHover: false, // Stop animation while hovering
    manualAdvance: false, // Force manual transitions
    randomStart: false, // Start on a random slide
  });
  
  //setup easting
  jQuery.easing.def = "easeOutExpo";
  
  // fancybox 
  $('.popup_img').fancybox();
  
  
  /************************************************************************************
   **    
   **    Homepage Featured Banner Rotator
   **
  ************************************************************************************/
  
  var currentBannerId = '';
  var nextBannerId;
  var bannerTimeout;

  // when a thumbnail is clicked
  $('.b_thumb').bind('click', function(e) {
    
    e.preventDefault();
    clearTimeout(bannerTimeout);
    nextBannerId = $(this).attr('id').replace('thumb_',''); //capture the current item ID
    if (nextBannerId == currentBannerId) {
      return false //can't select same item
    }
    
    updateThumbnails(nextBannerId);
    transition(currentBannerId, nextBannerId); // call the transition function
    bannerTimeout = setTimeout('nextBanner()', 5000);
  });
  
  // transition, fade and zoom the new image, hide the old
  function transition(currentId, nextId) {
    
    var nextCss = {
      'opacity' : '0',
      'display' : 'table',
      'z-index' : '1001',
    }
    
    $('#banner_' + currentId).css('z-index', '999');
    $('#banner_' + nextId).css(nextCss);
    
    $('#banner_' + nextId).stop().animate({
      opacity: 1,
      zoom: 1,
    }, 300, 'easeOutExpo', function() {
      $('#banner_' + currentId).fadeOut();
    });
        
    currentBannerId = nextId;
  }
  
  //update the thumbnails
  function updateThumbnails(activeThumb) {
    $('.b_thumb').each(function() {
      $(this).removeClass('b_thumb_active');
      $(this).find('.img_grayscale').stop().animate({opacity:0}, 500);
    });
    $('.thumb_' + activeThumb).addClass('b_thumb_active')
    $('.thumb_' + activeThumb).find('.img_grayscale').stop().animate({opacity:1}, 500);
  }
  
  // click the first by default
  $('#banner_nav li:first-child a').click();
  
 

  
  // Navigation Search box
  $('#global_search').bind('focus', function(e) {
    $('#global_search_container').animate({
      width : '290px',
    });
    $(this).animate({
      width : '240px', 
      left : '0px',
    });
  });
  
  $('#global_search').bind('blur', function(e) {
      $('#global_search_container').animate({
        width : '106px',
      });
      $(this).animate({
        width : '65px', 
        left : '0px'
      });
  });
  
  // standard image grid
  $('.image_grid li').bind('hover', function(e) {
    $(this).find('.grid_content').fadeToggle();
  });
  
});
