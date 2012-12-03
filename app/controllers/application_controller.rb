class ApplicationController < ActionController::Base

  # which pages are we caching
  before_filter :cache_rendered_page, :only => [:index, :contact, :team, :terms, :about, :special_programs_awards, :privacy, :volunteer]
  before_filter :get_sponsors
  before_filter :get_talks
  before_filter :get_nav_featured
  before_filter :get_header_models
  before_filter :capture_path
    
  # the application homepage
  def index
    @talks = Talk.current.order('RAND()').limit(8)
    @speakers = User.speaker.not_deleted.current.order('RAND()').limit(8)
    @featured = Chapter.homepage_featured.where('id != 67').order('RAND()').limit(7)
    @clinton = Chapter.find_by_id(67);
    @meta_data = {:page_title => "Welcome", :og_image => "http://www.chicagoideas.com/assets/application/logo.png", :og_title => "Chicago Ideas Week", :og_type => "website", :og_desc => "Chicago Ideas Week (CIW) is about the sharing of ideas, inspiring action and igniting change to positively impact our world. People who come to CIW are artists, engineers, technologists, inventors, scientists, musicians, economists, explorers-and, well...just innately passionate."}
  end
  
  
  def doc_raptor_send(options = { })
    default_options = { 
      :name             => controller_name,
      :document_type    => request.format.to_sym,
      #:test             => ! Rails.env.production?,
      :test => DOC_RAPTOR_TEST, #for now,
      :template => "#{self.controller_name}/pdf.html.haml" #don't really want to sandbox views for pdfs anywhere so lets keep them in main views folder for consitency
    }
    options = default_options.merge(options)
    options[:document_content] ||= render_to_string :template => "#{options[:template]}", :layout => 'pdf.html.haml'
    ext = options[:document_type].to_sym
    
    response = DocRaptor.create(options)
    
  end
  
  def get_header_models
    @current_year = Year.find(2012)
  end
  def get_sponsors
    @sponsors = Sponsor.featured_sponsors.order('RAND()')
  end
  def get_talks    
    @e_talks = TalkBrand.find(TALK_BRAND_ID).talks.current.order('RAND()').limit(10)
    @e_megatalks = TalkBrand.find(MEGATALK_BRAND_ID).talks.current.order('RAND()').limit(3)
    @e_speakers = User.speaker.not_deleted.current.order('RAND()').limit(10)
  end
  def get_nav_featured
    @nav_featured_chapters = Chapter.homepage_featured.order('RAND()').limit(2)
  end
  
  def about
    get_team_members
    @meta_data = {:page_title => "Who We Are", :og_title => "Chicago Ideas Week Who We Are", :og_type => "website"}
    render "application/about"
  end
  
  def contact
    @meta_data = {:page_title => "Contact Us", :og_title => "Chicago Ideas Week Contact", :og_type => "website"}
    render "application/contact"
  end
  
  def member_program
    @meta_data = {:page_title => "CIW Member Program", :og_title => "Chicago Ideas Week Member Program", :og_type => "website", :og_image => "http://www.chicagoideas.com/assets/application/member_program_lightbulb.jpg"}
    render "application/member_program"
  end
  
  def livestream
    @meta_data = {:page_title => "CIW Livestream", :og_title => "Chicago Ideas Week Livestream", :og_type => "website", :og_image => "http://www.chicagoideas.com/assets/application/member_program_lightbulb.jpg"}
    render "application/livestream"
  end
  
  def artist
    @meta_data = {:page_title => "CIW Artist in Residence", :og_title => "Chicago Ideas Week Artist in Residence", :og_type => "website"}
    render "application/artist_in_residence"
  end
  
  def faq
    @meta_data = {:page_title => "CIW Frequently Asked Questions", :og_title => "Chicago Ideas Week Frequently Asked Questions", :og_type => "website"}
    render "application/faq"
  end
  
  def badge
    if request.method == 'POST'
      @first_name = params['badge']['first_name']
      @last_name = params['badge']['last_name']
      @title = params['badge']['title']
      @organization = params['badge']['organization']
      @inspiration_1 = params['badge']['inspiration_1']
      @inspiration_2 = params['badge']['inspiration_2']
      @inspiration_3 = params['badge']['inspiration_3']
      
      pdf = doc_raptor_send({:document_type => "pdf".to_sym, :template => "application/badge_pdf.html.haml"})
      friendlyName = "CIW_Badge_#{@first_name}_#{@last_name}.pdf"
      friendlyName = friendlyName.gsub(" ", "")
      friendlyName = friendlyName.gsub("/", "_")
      File.open("#{Rails.root}/tmp/#{friendlyName}", 'w+b') {|f| f.write(pdf) }
      send_data pdf, :filename => friendlyName, :type => "pdf"
    else
      @meta_data = {:page_title => "CIW Build-a-Badge", :og_title => "Chicago Ideas Week Build-a-Badge", :og_type => "website"}
      render "application/badge"
    end
  end
  
   def project_youth
    @meta_data = {:page_title => "CIW PROJECT YOU(th)", :og_title => "Chicago Ideas Week PROJECT YOU(th)", :og_type => "website"}
    render "application/project_youth"
  end
  
  def sizzle
    @meta_data = {:page_title => "CIW Sizzle Reel", :og_title => "Chicago Ideas Week", :og_type => "website"}
    render "application/sizzle"
  end
  
  def media_inquiry
    @meta_data = {:page_title => "CIW Media Inquiry Form", :og_title => "Chicago Ideas Week", :og_type => "website"}
    render 'application/media_inquiry_form'
  end
  
  def send_contact
    AdminMailer.contact_form(params[:contact]).deliver
    render_json_response :ok, :notice => "Your message has been sent."
  end
  
  def community
  end
  
  def volunteer  
  end
  
  
  def special_programs_awards
    @meta_data = {:page_title => "Special Programs & Awards", :og_title => "Special Programs & Awards | Chicago Ideas Week", :og_type => "website", :og_desc => "Chicago Ideas Week (CIW) is about the sharing of ideas, inspiring action and igniting change to positively impact our world. People who come to CIW are artists, engineers, technologists, inventors, scientists, musicians, economists, explorers-and, well...just innately passionate."}
  end
  

  def terms
    @meta_data = {:page_title => "Terms of Use", :og_image => "http://www.chicagoideas.com/assets/application/logo.png", :og_title => "Terms of Use | Chicago Ideas Week", :og_type => "website", :og_desc => "Chicago Ideas Week (CIW) is about the sharing of ideas, inspiring action and igniting change to positively impact our world. People who come to CIW are artists, engineers, technologists, inventors, scientists, musicians, economists, explorers-and, well...just innately passionate."}
  end

  def privacy
    @meta_data = {:page_title => "Privacy Policy", :og_image => "http://www.chicagoideas.com/assets/application/logo.png", :og_title => "Privacy Policy | Chicago Ideas Week", :og_type => "website", :og_desc => "Chicago Ideas Week (CIW) is about the sharing of ideas, inspiring action and igniting change to positively impact our world. People who come to CIW are artists, engineers, technologists, inventors, scientists, musicians, economists, explorers-and, well...just innately passionate."}
  end
  
  # this contains the login and register links, we load it in via AJAX after the initial page has loaded.  
  # This allows us to cache fully rendered versions of the entire front end of the website.
  # This makes for an extremely fast experience for all our visitors
  def account_links
    json = {}
    json[:signed_in] = current_user ? true : false
    json[:admin] = (current_user and current_user.admin?) ? true : false
    json[:connected_to_twitter] = (current_user and current_user.connected_to_twitter?) ? true : false
    json[:connected_to_facebook] = (current_user and current_user.connected_to_facebook?) ? true : false
    json[:full_name] = (current_user ) ? current_user.name : nil
    json[:newsletter] = (current_user ) ? current_user.newsletter : nil
    render :json => json
  end
  
  
  # Capture the URL
  def capture_path
    cookies[:return_to] = request.path if request.method == "GET" && !devise_controller? && !request.xhr? && action_name != 'redirect'
    #puts cookies.to_json    
  end
  
  def after_sign_in_path_for(resource)
    #puts session.to_json
    cookies[:return_to] || user_root_path
  end

  
  private
  
    # appropriate headers to make our content cached - in heroku this gets cached by a squid like cache on top of our application servers
    # this makes for a very fast user experience
    def cache_rendered_page
      expires_in(1.hours)
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

    # get all staff members, sorted by priority
    def get_team_members
      # TODO:  add a sort column so we dont have to hard code these
      # in the meantime, with discrepancies across databases, need to only try to add team members that actually exist in the database
      @team = []
      (User.where(:id => 2).length > 0) ? @team << User.find(2) : nil            # Brad Keywell
      (User.where(:id => 62).length > 0) ? @team << User.find(62) : nil          # Eric Lefkofsky
      (User.where(:id => 5).length > 0) ? @team << User.find(5) : nil            # Jessica Malkin
      (User.where(:id => 6).length > 0) ? @team << User.find(6) : nil            # Carrie Kennedy
      (User.where(:id => 1824).length > 0) ? @team << User.find(1824) : nil      # Leah Marshall
      (User.where(:id => 155).length > 0) ? @team << User.find(155) : nil        # Brooke Scheyer
      (User.where(:id => 8).length > 0) ? @team << User.find(8) : nil            # Amy Walsh
      (User.where(:id => 1945).length > 0) ? @team << User.find(1945) : nil      # Tommy King
      (User.where(:id => 1891).length > 0) ? @team << User.find(1891) : nil      # Jennifer Nelson
      (User.where(:id => 2163).length > 0) ? @team << User.find(2163) : nil      # Metra Farrari
      (User.where(:id => 1825).length > 0) ? @team << User.find(1825) : nil      # Becky Ahasic
      (User.where(:id => 4).length > 0) ? @team << User.find(4) : nil            # Corey Nianick
      (User.where(:id => 1271).length > 0) ? @team << User.find(1271) : nil      # Kelly Hagler
      (User.where(:id => 1266).length > 0) ? @team << User.find(1266) : nil      # Prash Sabharwal
      (User.where(:id => 2184).length > 0) ? @team << User.find(2184) : nil      # Mary McDonnell
      (User.where(:id => 496).length > 0) ? @team << User.find(496) : nil        # Alicia Bassuk
      (User.where(:id => 156).length > 0) ? @team << User.find(156) : nil        # Barbara Pollack
      (User.where(:id => 1).length > 0) ? @team << User.find(1) : nil            # Craig Ulliott

      User.staff.not_deleted.where("id not in (2,62,5,6,1824,155,8,1945,1891,2163,1825,4,1271,1266,2184,496,156,1)").all.each do |u|
        @team << u
      end
      @team
    end

end
