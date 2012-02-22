/*
 * kohtweets - jQuery Plugin
 * Simple, templatable twitter API widget
 *
 *
 * Copyright © 2011 kohactive
 * http://www.kohactive.com
 *
 * Version: 1.0.1 (10/21/2011)
 * Requires: jQuery v1.6+
 *
 * Dual licensed under the MIT and GPL licenses:
 *   http://www.opensource.org/licenses/mit-license.php
 *   http://www.gnu.org/licenses/gpl.html
 */
 

/*
 * REQUIRED DEPENDENCY
 *
 * mustache.js — http://mustache.github.com/
 * Underscore.js 1.3.1 - http://documentcloud.github.com/underscore
 * Pretty.js - http://ejohn.org/blog/javascript-pretty-date/
 *
 *
*/


/*
  jQuery AutoLink
  MIT License
*/


(function($) {
    var url_regexp = /(https?:\/\/[　-熙ぁ-ヴーA-Za-z0-9~\/._\?\&=\-%#\+:\;,\@\']+)/;
    var hashtag_item = /\B#([_a-z0-9]+)/ig;
    var screenname_item = /\B@([_a-z0-9]+)/ig;
    
    $.fn.autolink = function() {
    
        return this.each(function(){
    
            var desc = $(this);
    
            desc.textNodes().each(function(){
            
                var text = $(this);
            
                if(text.parent().get(0).nodeName != 'A') {
                    text.replaceWith(this.data.replace(url_regexp, function($0, $1) {
                        return '<a target="_blank" href="' + $1 +'">' + $1 + '</a>';
                    }));

                }
            });
            
        });
    }


  $.fn.hashtaglink = function() {
        return this.each(function(){
            var desc = $(this);
            desc.textNodes().each(function(){
                var text = $(this);
                if(text.parent().get(0).nodeName != 'A') {
                    text.replaceWith(this.data.replace(hashtag_item, function($0, $1) {
                        return '<a target="_blank" href="http://www.twitter.com/search?q=' + $1 +'">#' + $1 + '</a>';
                    }));
                }
            });
        });
    }
    
    $.fn.attaglink = function() {
        return this.each(function(){
            var desc = $(this);
            desc.textNodes().each(function(){
                var text = $(this);
                if(text.parent().get(0).nodeName != 'A') {
                    text.replaceWith(this.data.replace(screenname_item, function($0, $1) {
                        return '<a target="_blank" href="http://www.twitter.com/' + $1 +'">@' + $1 + '</a>';
                    }));
                }
            });
        });
    }



    $.fn.textNodes = function() {
        var ret = [];

        (function(el){
            if (!el) return;
            if ((el.nodeType == 3)) {
                ret.push(el);
            } else {
                for (var i=0; i < el.childNodes.length; ++i) {
                    arguments.callee(el.childNodes[i]);
            }
          }
        })(this[0]);
        return $(ret);
    }
})(jQuery);




(function($) {

  $.fn.kohtweets = function(options) {
    
    //variables
    var element = this;
    if (options.preloader === "true") $(element).css('background', 'url(' + options.preloader_url + ') center center no-repeat'); 
    var type = (options.type).toLowerCase();
    var template = options.template; 
    var screen_name = options.screen_name;
    var count = options.count;
    
    var json_url;
    
    switch (type) {      
      case "username":
        json_url = 'https://api.twitter.com/1/statuses/user_timeline.json?screen_name='+screen_name+'&count='+count+'&callback=?';
      break;
      case "search":
        json_url = 'https://search.twitter.com/search.json?q='+screen_name+'&rpp='+count+'&callback=?';
      break;
    }
    
    //Make the AJAX requeset and parse results
    $.getJSON(json_url, function(results) {
      
      results = (type == "search") ? results.results : results;
      
      resultsParsed = [];
      
      // Prettify the Timestamp
      _.each(results, function(item) {
        item.created_at = prettyDate(item.created_at);
        resultsParsed.push(item);
      });
      
      
      var tweets = Mustache.to_html(template, { tweets: resultsParsed } );
      
      tweets = $(tweets).autolink();
      tweets = $(tweets).hashtaglink();
      tweets = $(tweets).attaglink();
      
      $(element).css('background' , '');
      $(element).html(tweets);
    
    });

  }
  
  
  
})(jQuery);