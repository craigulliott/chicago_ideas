CraigsAdmin::Application.routes.draw do
  # the API                                                                          (http://api.domain.com/)
  # ---------------------------------------------------------------------------------------------------------
  namespace :api do
    #scope :module => "api", :as => "api" do
  
      # the documentation
      root :to => 'documentation#documentation'
      
      resources :talks, :defaults => { :format => 'json', :version => '1.1.2' } do
        resources :chapters, :only => [:index]
      end
      resources :chapters, :defaults => { :format => 'json', :version => '1.1.2' }
      resources :years, :defaults => { :format => 'json', :version => '1.1.2' }
      resources :days, :defaults => { :format => 'json', :version => '1.1.2' } do
        resources :talks, :only => [:index]
        resources :events, :only => [:index]
      end
      resources :tracks, :defaults => { :format => 'json', :version => '1.1.2' }
      resources :partners, :defaults => { :format => 'json', :version => '1.1.2' }
      resources :quotes, :defaults => { :format => 'json', :version => '1.1.2' }
      resources :sponsors, :defaults => { :format => 'json', :version => '1.1.2' }
      resources :press_clippings, :defaults => { :format => 'json', :version => '1.1.2' }
      resources :events, :defaults => { :format => 'json', :version => '1.1.2' } do
        resources :talks, :only => [:index]
      end
      resources :speakers, :defaults => { :format => 'json', :version => '1.1.2' } do
        resources :talks, :only => [:index]
      end
      
      resources :search, :defaults => { :format => 'json', :version => '1.1.2' }
      resources :jobs, :defaults => { :format => 'json', :version => '1.1.2' }
      
      #resources :speaker, :only => [:list, :show] do
        # search for speakers
       # get :search, :on => :collection
        # resources
       # resources :talks, :only => [:list, :show]
      #end
  
    #end
  end
    
    
  # the Site
  # ---------------------------------------------------------------------------------------------------------
  
  root :to => 'application#index'

  # we load in this dynamic content after the page loads, this allows us to cache the entire front end of the website
  match 'account_links', :to => 'application#account_links'

  # website pages
  # ----------------------------------------------------------------
  match 'search(.:format)', :to => 'search#index', :as => 'search'
  match 'search/speakers(:format)', :to => 'search#speakers'
  match 'search/videos(:format)', :to => 'search#videos'

  # legalese 
  match 'privacy', :to => 'application#privacy'
  match 'terms', :to => 'application#terms'

  # news about CIW
  resources :press_clippings, :only => [:index, :show]
  match 'press_releases', :to => 'press_clippings#releases'
  match 'newsroom', :to => 'press_clippings#newsroom'

  # sponsors and partners
  # ----------------------------------------------------------------
  resources :sponsors, :only => [:index]
  resources :partners, :only => [:index, :apply]
  match 'partners/apply', :to => 'partners#apply', :as => 'partners_apply'
  match 'sponsors/media_partners', :to => 'sponsors#media_partners'

  # users
  # ----------------------------------------------------------------
  resources :users, :only => [] do
    collection do 
      # actions
      post :newsletter
    end
    member do
      # pages
      # actions
      put :disconnect_facebook
      put :disconnect_twitter
    end
  end
  # user account page
  match 'dashboard' => 'users#dashboard', :as => 'user_root'
  # authentication for the website, uses Devise and Omniauth for facebook and twitter connect
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  # forms we capture data from
  resources :volunteers, :only => [:new, :create]
  resources :community_partner_applications, :only => [:new, :create]
  resources :affiliate_event_applications, :only => [:new, :create]
  resources :bhsi_applications, :only => [:index, :new, :create] do
    collection do
      get :redirect
    end
  end
  
  resources :think_chicago_applications, :path => "/thinkchicago_applications", :only => [:index, :new, :create] do
    collection do
      get :redirect
    end
  end
  
  resources :edison_talks_applications, :only => [:index, :new, :create] do
    collection do
      get :redirect
    end
  end
  
  #resources :years, :only => [:show]
  resources :years, :only => [:show] do
    match 'speakers', :to => 'users#list_speakers'
    match 'speakers/edison', :to => 'users#list_edison_speakers'
    match 'speakers/top_picks', :to => 'users#speakers_top_picks'
    match 'talks/mega_talks', :to => 'talks#mega_talks'
    match 'events/labs', :to => 'events#labs'
    match 'events/partner_programs', :to => 'events#partner_programs'
    match 'events/affiliate_event', :to => 'events#affiliate_event'
    match 'videos', :to => 'chapters#index'
    match 'press_clippings', :to => 'press_clippings#index'
    match 'press_releases', :to => 'press_clippings#releases'
    match 'schedule', :to => 'schedule#index'
    match ':month_id/:day_id/schedule', :to => 'schedule#index'
    match 'members', :to => 'members#index'
    
    # talks and events
    # ----------------------------------------------------------------
    resources :events, :only => [:index, :show] do
      # home pages for the different event types
      collection do
        get :labs
        get :partner_programs
        get :affiliate_event
      end
    end
    
    resources :talks, :only => [:index] do
      # home pages for the different talk types
      collection do
        get :mega_talks
        get :edison_talks
      end
    end
  end
  
  # Schedule redirect
  match "schedule" => redirect("/years/2012/schedule")
  
  # Edison Speakers redirect
  match "edison" => redirect("/years/2012/speakers/edison")
  match 'project_youth', :to => 'application#project_youth'
  
  # teams members and speakers are both a type of user, so are handled by the users controller
  match 'team_members', :to => 'users#list_team_members'
  match 'team_members/:id', :to => 'users#team_member', :as => "team_member"
  match 'speakers/edison', :to => 'users#list_edison_speakers'
  match 'speakers/project_youth', :to => 'users#list_project_youth_speakers'
  match 'speakers', :to => 'users#list_speakers'
  match 'speakers/page/:page', :to => 'users#list_speakers'
  match 'speakers/:id', :to => 'users#speaker', :as => "speaker"
 
  
  # Static Pages
  match 'livestream', :to => 'application#livestream'
  match 'about', :to => 'application#about'
  match 'mission', :to => 'application#mission'
  match 'programs', :to => 'application#programs'
  match 'impact', :to => 'application#impact'
  match 'member_program', :to => 'application#member_program'
  match 'artist', :to => 'application#artist'
  match 'faq', :to => 'application#faq'
  match 'whatifchicago', :to => 'application#whatifchicago'
  match 'support', :to => 'application#support'
  #match 'badge', :to => 'application#badge'
  match 'speaker/recommend_speaker', :to => 'users#recommend_speaker', :as => 'recommend_speaker'
  match 'special_programs', :to => 'application#special_programs_awards'
  
  # BHSI
  match 'special_programs/bhsi', :to => 'bhsi#index', :as => 'blum_helfand'
  match 'special_programs/bhsi/fellows', :to => 'bhsi#fellows'
  match 'special_programs/bhsi/previous_fellows', :to => 'bhsi#previous_fellows'
  match 'special_programs/bhsi/nominate', :to => 'bhsi#nominate_form'
  
  # We changed the url post-launch :(
  match "special_programs/blum_helfand_fellowship" => redirect("/special_programs/bhsi")
  match "special_programs/blum_helfand_fellowship/previous_fellows" => redirect("/special_programs/bhsi/previous_fellows")
  match "special_programs/blum_helfand_fellowship/nominate" => redirect("/special_programs/bhsi/nominate")
  match '/bhsi' => redirect("/special_programs/bhsi")
  
  # ThinkChicago
  match 'special_programs/thinkchicago', :to => 'think_chicago#index', :as => 'thinkchicago'
  match '/special_programs/think_chicago' => redirect("/special_programs/thinkchicago")
  match '/thinkchicago' => redirect("/special_programs/thinkchicago")
  
  match 'community', :to => 'application#community'
  match 'sizzle', :to => 'application#sizzle'
  match 'info_2012', :to => 'application#sizzle'
  match 'media/inquiry', :to => 'application#media_inquiry', :as => 'media_inquiry_form'

  # contact form
  match 'contact', :to => 'application#contact'
  match 'send_contact', :to => 'application#send_contact'
  
  # guest blogger form
  match 'guest_blogger_form', :to => 'application#guest_blogger_form'
  
  # talks and events
  # ----------------------------------------------------------------
  resources :events, :only => [:index, :show] do
    # home pages for the different event types
    collection do
      get :labs
      get :partner_programs
      get :affiliate_event
    end
  end
  match 'events/labs/host_form', :to => 'events#labs_host_form', :as => 'labs_host_form'

  resources :talks, :only => [:index, :show] do
    # home pages for the different talk types
    collection do
      get :mega_talks
      get :edison_talks
    end
  end
  resources :tracks, :only => [:show]
  
  
  resources :jobs, :only => [:index, :show]
  

  # all videos are of chapters, so pass to the chapter controller
  match 'videos', :to => 'chapters#index'
  match 'videos/edison', :to => 'chapters#edison'
  match 'videos/:id', :to => 'chapters#show', :as => "video"
  
  
  match 'events/partner_programs/:id', :to => 'events#partner_programs', :as => 'partner_program'
  
  match 'current', :to => 'chapters#current'

  # the Admin                                                                   (http://www.domain.com/admin)
  # ---------------------------------------------------------------------------------------------------------
  namespace :admin do
  
    root :to => 'admin#index'

    resources :jobs do
      member do
        # pages
        get :notes
      end
      resources :notes, :only => [:new, :create]
    end

    resources :community_partner_applications do
      member do
        # pages
        get :notes
      end
      resources :notes, :only => [:new, :create]
    end
    
    resources :affiliate_event_applications do
      member do
        # pages
        get :notes
      end
      resources :notes, :only => [:new, :create]
    end

    resources :volunteers do
      member do
        # pages
        get :notes
      end
      resources :export
        collection do
          get :export
        end
      resources :notes, :only => [:new, :create]
    end

    resources :bhsi_applications do
      member do
        # pages
        get :notes
      end
      resources :notes, :only => [:new, :create]
    end
    
    resources :think_chicago_applications do
      member do
        # pages
        get :notes
      end
      resources :export
        collection do
          get :export
        end
      resources :notes, :only => [:new, :create]
    end
    
    resources :edison_talks_applications do
      member do
        # pages
        get :notes
      end
      resources :export
        collection do
          get :export
        end
      resources :notes, :only => [:new, :create]
    end

    resources :press_clippings do
      member do
        # pages
        get :notes
      end
      resources :notes, :only => [:new, :create]
    end

    resources :talk_photos do
      member do
        # pages
        get :notes
      end
      resources :notes, :only => [:new, :create]
    end

    resources :chapter_photos do
      member do
        # pages
        get :notes
      end
      resources :notes, :only => [:new, :create]
    end

    resources :event_photos do
      member do
        # pages
        get :notes
      end
      resources :notes, :only => [:new, :create]
    end

    resources :quotes do
      member do
        # pages
        get :notes
      end
      resources :notes, :only => [:new, :create]
    end

    resources :performances do
      member do
        # pages
        get :notes
      end
      resources :notes, :only => [:new, :create]
    end

    resources :chapters do
      member do
        # pages
        get :notes
        get :chapter_photos
      end
      resources :notes, :only => [:new, :create]
      resources :chapter_photos, :only => [:new, :create]
    end

    resources :event_brands do
      member do
        # pages
        get :notes
      end
      resources :notes, :only => [:new, :create]
    end

    resources :talk_brands do
      member do
        # pages
        get :notes
      end
      resources :notes, :only => [:new, :create]
    end
    
    resources :member_types do
      member do
        # pages
        get :notes
      end
      resources :notes, :only => [:new, :create]
    end
    
    resources :members do
      member do
        # pages
        get :notes
      end
      resources :notes, :only => [:new, :create]
    end
    
    resources :venues do
      member do
        # pages
        get :notes
      end
      resources :notes, :only => [:new, :create]
    end

    resources :talks do
      member do
        # pages
        get :notes
        get :chapters
        get :talk_photos
      end
      resources :notes, :only => [:new, :create]
      resources :chapters, :only => [:new, :create]
      resources :talk_photos, :only => [:new, :create]
    end

    resources :tracks do
      member do
        # pages
        get :notes
      end
      resources :notes, :only => [:new, :create]
    end

    resources :events do
      member do
        # pages
        get :notes
        get :event_photos
        get :event_speakers
      end
      resources :notes, :only => [:new, :create]
      resources :event_photos, :only => [:new, :create]
      resources :event_speakers, :only => [:new, :create]
    end
    
    resources :event_speakers do
      member do
        # pages
        get :notes
      end
      resources :notes, :only => [:new, :create]
    end

    resources :sponsors do      
      collection do
        post :sort
      end
      member do
        # pages
        get :notes
      end
      resources :notes, :only => [:new, :create]
    end

    resources :sponsorship_levels do
      collection do
        post :sort
      end
      member do
        # pages
        get :notes
      end
      resources :notes, :only => [:new, :create]
    end
    

    resources :partners do
      member do
        # pages
        get :notes
      end
      resources :notes, :only => [:new, :create]
    end

    resources :days do
      member do
        # pages
        get :notes
      end
      resources :notes, :only => [:new, :create]
    end
    
    resources :notes, :only => [] do
      member do
        # notes have attachemts, which are passed through the application because the 
        # files are not publically availiable through the Internet
        get :attachment
      end
    end
  
    resources :users do
      collection do
        # pages
        get :administrators
        get :staff
        get :speakers
      end
      member do
        # pages
        get :notes
        get :log_entries
        # methods
        get :undelete
        get :delete
        get :edit_password
        put :update_password
      end
      resources :export
        collection do
          get :export
        end
      resources :notes, :only => [:new, :create]
    end
  
    resources :venues
  
  end
  
  

end
