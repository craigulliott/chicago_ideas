module CommonLinksHelper

  # sometimes we need to override the asset pipeline host address when refercing images in og:metadata
  # this is a method very similar to rails core methods for halding paths and urls, but this one doesnt currently exist (true as of rails 3.1)
  def image_url(source)
    abs_path = image_path(source)
    
    unless abs_path =~ /^http/
      abs_path = "#{request.protocol}#{request.host_with_port}#{abs_path}"
    end
   abs_path
  end

  # a wrapper for link_to which includes an icon sprite (we use jquery_ui icons)
  def icon_link_to body, url, icon, html_options={}
    # if url is a model, then we need to turn it ito a path first
    if url.kind_of? ActiveRecord::Base
      url = url_for(url)
    end

    # did we provide an icon for this link
    if icon
      icon_html = icon(icon, html_options[:icon_set])
      body = "#{icon_html} #{body}".html_safe
      html_options[:class] = "#{html_options[:class]} icon"
    end
    
    return link_to body, url, html_options

  end


  # Helpers below are used to create very common admin area links, such as to add, edit, delete models
  # ------------------------------------------------------------------------------------------------------

  # destroy link
  def destroy_model_link m, reload_on_success=false
    reload = reload_on_success ? 'reload' : nil

    destroy_path = send("admin_#{m.class.name.underscore}_path", m)

    return icon_link_to 'remove', destroy_path, 'closethick', :remote => true, :class => "row-delete destroy #{reload}", :method => :delete, :confirm => 'Are you sure?'
  end

  # very common edit model link which uses AJAX and a dialog
  def edit_model_link m, reload_on_success=false
    edit_path = send("edit_admin_#{m.class.name.underscore}_path", m)
    reload = reload_on_success ? 'reload' : nil
    return icon_link_to 'edit', edit_path, 'pencil', :remote => true, :class => "dialog edit #{reload}"
  end

  # very common new model link which uses AJAX and a dialog
  def new_model_link klass, parent=nil, reload_on_success=false
    new_path = parent.nil? ? send("new_admin_#{klass.name.underscore}_path") : send("new_admin_#{parent.class.name.underscore}_#{klass.name.underscore}_path", parent)
    reload = reload_on_success ? 'reload' : nil
    return icon_link_to "add #{klass.name.titlecase.downcase}", new_path, 'plusthick', :remote => true, :class => "dialog new #{reload}"
  end

  # delete and undelete links, which toggle back and forth via javascript
  def delete_model_link m, reload_on_success=false
    reload = reload_on_success ? 'reload' : nil

    delete_path = send("delete_admin_#{m.class.name.underscore}_path", m)
    delete_link = icon_link_to 'delete', delete_path, 'trash', :confirm => 'Are you sure?', :remote => true, :class => "toggle delete #{reload}", :style => ( m.deleted? ? "display:none;" : nil)
    
    undelete_path = send("undelete_admin_#{m.class.name.underscore}_path", m)
    undelete_link = icon_link_to 'restore', undelete_path, 'arrowreturnthick-1-n', :confirm => 'Are you sure?', :remote => true, :class => "toggle undelete #{reload}", :style => ( m.deleted? ? nil : "display:none;")

    return content_tag(:div, delete_link+undelete_link, :class => "toggle") 
  end

  # flag and unflag links, which toggle back and forth via javascript
  def flag_model_link m, reload_on_success=false
    reload = reload_on_success ? 'reload' : nil

    flag_path = send("flag_admin_#{m.class.name.underscore}_path", m)
    flag_link = icon_link_to 'flag', flag_path, 'flag', :remote => true, :class => "toggle flag #{reload}", :style => ( m.flagged? ? "display:none;" : nil)
    
    unflag_path = send("unflag_admin_#{m.class.name.underscore}_path", m)
    unflag_link = icon_link_to 'unflag', unflag_path, 'flag', :remote => true, :class => "toggle unflag #{reload}", :style => ( m.flagged? ? nil : "display:none;")

    return content_tag(:div, flag_link+unflag_link, :class => "toggle") 
  end

  # publish and unpublish links, which toggle back and forth via javascript
  def publish_model_link m, reload_on_success=false
    reload = reload_on_success ? 'reload' : nil

    publish_path = send("publish_admin_#{m.class.name.underscore}_path", m)
    publish_link = icon_link_to 'publish', publish_path, 'plusthick', :remote => true, :class => "toggle publish #{reload}", :style => ( m.published? ? "display:none;" : nil)
    
    unpublish_path = send("unpublish_admin_#{m.class.name.underscore}_path", m)
    unpublish_link = icon_link_to 'unpublish', unpublish_path, 'minusthick', :remote => true, :class => "toggle unpublish #{reload}", :style => ( m.published? ? nil : "display:none;")

    return content_tag(:div, publish_link+unpublish_link, :class => "toggle") 
  end
  
  def export_model_link klass, format, title=nil
    if title.nil?
      title = "export all #{klass.name.pluralize.downcase}"
    end
  	export_path = send("export_admin_#{klass.name.pluralize.underscore}_path") + ".#{format}"
    return link_to title, export_path
  end

end
