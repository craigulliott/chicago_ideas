module ApplicationHelper
  
  def conditional_html( lang = "en", &block )
    fb_meta = "xml:lang='en' xmlns:fb='http://www.facebook.com/2008/fbml' xmlns:og='http://opengraphprotocol.org/schema/' xmlns='http://www.w3.org/1999/xhtml'"
    haml_concat Haml::Util::html_safe <<-"HTML".gsub( /^\s+/, '' )
      <!--[if lt IE 7 ]><html lang="#{lang}" class="no-js ie6" #{fb_meta}> <![endif]-->
      <!--[if IE 7 ]><html lang="#{lang}" class="no-js ie7" #{fb_meta}> <![endif]-->
      <!--[if IE 8 ]><html lang="#{lang}" class="no-js ie8" #{fb_meta}> <![endif]-->
      <!--[if IE 9 ]><html lang="#{lang}" class="no-js ie9" #{fb_meta}> <![endif]-->
      <!--[if (gte IE 9)|!(IE)]><!--> <html lang="#{lang}" class="no-js" #{fb_meta}> <!--<![endif]-->      
    HTML
    haml_concat capture( &block ) << Haml::Util::html_safe( "\n</html>" ) if block_given?
  end
  
  # Simple way to truncate a paragraph
=begin
  def truncate_words(text, length = 250, end_string = ' ...')
    words = text.split()
    words[0..(length-1)].join(' ') + (words.length > length ? end_string : '')
  end
=end

  def truncate_words text, length=55, truncate_string="..."
    return if text.nil?
    l = length - truncate_string.chars.length
    text.chars.length > length ? text[/\A.{#{l}}\w*\;?/m][/.*[\w\;]/m] + truncate_string : text
  end
  
  def truncate_words text, length=55, separator = ' ', truncate_string = '...'
    
  end
  
  def truncate_words(text, length = 30, separator = ' ', truncate_string = '...')
    return if text.nil?
    truncated_text = text.split[0..length].join(separator)
    if(truncated_text == text)
      text
    else
      truncated_text + ' ' + truncate_string
    end
  end
    
    
  
  # a robust method to display flash messages
  def flash_helper keys=[:notice, :alert]
    # allow keys to be a symbol or an array of symbols
    keys = [keys] unless keys.kind_of? Array
    
    # html from each message
    html = ''
    flash.each do |key, msg|
      html = html + content_tag(:div, msg, :class => key) if keys.index key
    end
    html.html_safe
  end

  # a convinience method to render the breadcrumbs template
  def breadcrumbs base_model, reload_on_success=false
    render "shared/breadcrumbs_item", :base_model => base_model
  end

  # a page title which gracefully degrades
  def page_title
    if @page_title
      "#{@page_title} | Chicago Ideas Week"
    elsif params[:page_title]
      "#{params[:page_title]} | Chicago Ideas Week"
    else
      "#{params[:controller].split('/').last.singularize.titlecase} #{section_title} | Chicago Ideas Week"
    end
  end

  # a wrapper for @section_title, which gracefully degrdes to a presentable form of the current action name
  def section_title
    @section_title || params[:action].titlecase
  end
  
  # creates a span for an icon sprite (jquery ui)
  def icon name, subset=nil
    css_class = "ui-icon ui-icon-#{name}"
    css_class += " ui-icon-#{subset}" if subset
    content_tag(:span, nil, :class => css_class)
  end

  # return 'active' if the current controller action matches the provided action_name
  def active_for action_name
    params[:action].to_s == action_name.to_s ? 'active' : ''
  end

  # return 'active' if the current controller name matches the provided controller_name
  def active_for_controller controller_name
    params[:controller].to_s == controller_name.to_s ? 'active' : ''
  end

  # return 'active' if the current controller and action name matches the provided controller_name and action_name
  def active_for_controller_and_action controller_name, action_name
    params[:controller].to_s == controller_name.to_s && params[:action].to_s == action_name.to_s ? 'active' : ''
  end

  #  string representation of how long ago an object was created, or 'never' if the object doesnt exist
  def created_ago_or_never m
    return 'never' unless m.present?
    return m.created_at.to_s(:ago)
  end
  

    

end
