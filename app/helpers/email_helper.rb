module EmailHelper
  
  # email helpers, because emails have lots of inline css and we want to DRY that up
  # ----------------------------------------------------------------------------------------------------
  def email_spacer
    render 'shared/email_spacer'
  end

  def email_h1 header_text
    ('<h1 style="font-weight:normal; font-size:20px; margin-top:0; font-family: Arial, sans-serif; color:#000000;">'+header_text+'</h1>').html_safe
  end

  def email_h2 header_text
    ('<h2 style="font-weight:normal; font-size:18px; margin-top:0; font-family: Arial, sans-serif; color:#000000;">'+header_text+'</h2>').html_safe
  end

  def email_h3 header_text
    ('<h3 style="font-weight:normal; font-size:16px; margin:0; font-family: Arial, sans-serif; color:#000000;">'+header_text+'</h3>').html_safe
  end

  def email_h4 header_text
    ('<h4 style="font-weight:normal; font-size:14px; margin-top:0; font-family: Arial, sans-serif; color:#000000;">'+header_text+'</h4>').html_safe
  end

  def email_p_style
    'font-size:14px; padding-left:25px;'.html_safe
  end

  def email_link_to link_text, link_url
    link_to link_text, link_url, :style => 'color: #121212; font-family: Arial, sans-serif; font-size: 14px;'
  end
  
end