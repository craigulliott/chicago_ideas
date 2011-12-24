module ApplicationHelper

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
      "#{@page_title} | Admin"
    elsif params[:page_title]
      "#{params[:page_title]} | Admin"
    else
      "#{params[:controller].split('/').last.singularize.titlecase} #{section_title} | Admin"
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

  #  string representation of how long ago an object was created, or 'never' if the object doesnt exist
  def created_ago_or_never m
    return 'never' unless m.present?
    return m.created_at.to_s(:ago)
  end

end
