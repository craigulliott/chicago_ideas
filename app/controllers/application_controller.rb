class ApplicationController < ActionController::Base

  # which pages are we caching
  before_filter :cache_rendered_page, :only => [:index, :contact, :team, :terms]
  
  
  before_filter :authenticate_user!, :only => [:dashboard]
  
  # the application homepage
  def index
    @talks = Talk.search_sort_paginate(params)
    #@topics = Topic.search_sort_paginate(params)
  end

  
  def register
  end
  
  def login
  end
  
  def archives
  end
  
  def search
  end
  


  def contact
  end

  def send_contact
    AdminMailer.contact_form(params[:contact]).deliver
    render_json_response :ok, :notice => "Your message has been sent."
  end
  
  def team
    @staff_bios = StaffBio.by_sort_column
  end

  def terms
  end

  # users account page
  def dashboard
    @user = current_user
  end
  
  # this contains the login and register links, we load it in via AJAX after the initial page has loaded.  
  # This allows us to cache fully rendered versions of the entire front end of the website.
  # This makes for an extremely fast experience for all our visitors
  def account_links
    render 'account_links', :layout => false
  end
  
  private
  
    # appropriate headers to make our content cached - in heroku this gets cached by a squid like cache on top of our application servers
    # this makes for a very fast user experience
    def cache_rendered_page
      response.headers['Cache-Control'] = 'public, max-age=300'
    end
  
    # recursive call for deep cloning a hash in a way which doesnt keep non scalar types also doesnt modify the params array
    # we use this in logging before_filters
    def collect_hash_contents hash
      new_hash = {}
      hash.each do |key, val|
        # we only keep certain types
        if val.kind_of? Hash
          new_hash[key] = collect_hash_contents(val)
        elsif val.kind_of? String
          new_hash[key] = val
        else
          new_hash[key] = '-stripped-'
        end
      end
      new_hash
    end

end
