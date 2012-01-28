class ApplicationController < ActionController::Base

  # which pages are we caching
  before_filter :cache_rendered_page, :only => [:index, :contact, :team, :terms, :about, :special_programs_awards, :privacy, :volunteer]
  before_filter :get_sponsors
  before_filter :get_talks
  before_filter :get_nav_featured
  before_filter :get_header_models
  
  before_filter :authenticate_user!, :only => [:dashboard]
  
  # the application homepage
  def index
    @talks = Talk.order('RAND()').limit(8)
    @speakers = User.speaker.order('RAND()').limit(8)
    @sponsors = Sponsor.all
    @featured = Chapter.homepage_featured.order('RAND()').limit(8)
    @page_title = "Welcome"
  end
  
  def get_header_models
    @current_year = Year.find(2012)
  end
  def get_sponsors
    @sponsors = Sponsor.all
  end
  def get_talks
    @e_megatalks = TalkBrand.find_by_name("Megatalk").talks.order('RAND()').limit(3)
    @e_talks = TalkBrand.find_by_name("Talk").talks.order('RAND()').limit(10)
    @e_speakers = User.speaker.order('RAND()').limit(10)
  end
  def get_nav_featured
    @nav_featured_chapters = Chapter.homepage_featured.order('RAND()').limit(2)
  end
  
  def about
    get_team_members
    render "application/about"
  end
  
  def send_contact
    AdminMailer.contact_form(params[:contact]).deliver
    render_json_response :ok, :notice => "Your message has been sent."
  end
  
  def recommend_speaker
  end
  
  def community
  end
  
  def volunteer  
  end
  
  
  def special_programs_awards  
  end
  
  def blum_helfand
  end

  def terms
  end

  def privacy
  end

  # users account page
  def dashboard
    @user = current_user
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
  
  private
  
    # appropriate headers to make our content cached - in heroku this gets cached by a squid like cache on top of our application servers
    # this makes for a very fast user experience
    def cache_rendered_page
      expires_in(24.hours)
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
      # TODO:  add a sort column
      @team = []
      @team << User.find(2)
      @team << User.find(1)
      @team << User.find(5)
      @team << User.find(6)
      @team << User.find(3)
      User.staff.not_deleted.where('id not in (2,1,5,6,3)').all.each do |u|
        @team << u
      end
      @team
    end

end
