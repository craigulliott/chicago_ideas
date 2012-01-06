class ApplicationController < ActionController::Base

  # the application homepage
  def index
    @talks = Talk.search_sort_paginate(params)
    #@topics = Topic.search_sort_paginate(params)
  end

  def videos
    
  end
  
  def about
  end
  
  def community
  end
  
  def blog
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

  private
  
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
