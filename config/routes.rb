CraigsAdmin::Application.routes.draw do
  # the API                                                                          (http://api.domain.com/)
  # ---------------------------------------------------------------------------------------------------------
  namespace :api do
    #scope :module => "api", :as => "api" do
  
      # the documentation
      root :to => 'documentation#documentation'
      
      resources :talks, :defaults => { :format => 'json', :version => '1.1.2' }
      resources :chapters, :defaults => { :format => 'json', :version => '1.1.2' }
      resources :years, :defaults => { :format => 'json', :version => '1.1.2' }
      resources :days, :defaults => { :format => 'json', :version => '1.1.2' }
      resources :tracks, :defaults => { :format => 'json', :version => '1.1.2' }
      resources :partners, :defaults => { :format => 'json', :version => '1.1.2' }
      resources :quotes, :defaults => { :format => 'json', :version => '1.1.2' }
      resources :sponsors, :defaults => { :format => 'json', :version => '1.1.2' }
      resources :press_clippings, :defaults => { :format => 'json', :version => '1.1.2' }
      resources :events, :defaults => { :format => 'json', :version => '1.1.2' }
      resources :speakers, :defaults => { :format => 'json', :version => '1.1.2' }
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
  resources :press_clippings, :only => [:index]
  

  # sponsors and partners
  # ----------------------------------------------------------------
  resources :sponsors, :only => [:index]
  resources :partners, :only => [:index, :apply]
  match 'partners/apply', :to => 'partners#apply', :as => 'partners_apply'

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
  resources :bhsi_applications, :only => [:new, :create]
  
  resources :years, :only => [:show]
  
  # teams members and speakers are both a type of user, so are handled by the users controller
  match 'team_members', :to => 'users#list_team_members'
  match 'team_members/:id', :to => 'users#team_member', :as => "team_member"
  match 'speakers', :to => 'users#list_speakers'
  match 'speakers/page/:page', :to => 'users#list_speakers'
  match 'speakers/:id', :to => 'users#speaker', :as => "speaker"
  
  # Static Pages
  match 'about', :to => 'application#about'
  match 'recommend/speaker', :to => 'application#recommend_speaker', :as => 'recommend_speaker'
  match 'special_programs', :to => 'application#special_programs_awards'
  match 'special_programs/blum_helfand_fellowship', :to => 'application#blum_helfand', :as => 'blum_helfand'
  match '/bhsi', :to => 'application#blum_helfand'
  match 'community', :to => 'application#community'
  match 'sizzle', :to => 'application#sizzle'
  match 'info_2012', :to => 'application#sizzle'

  # contact form
  match 'contact', :to => 'application#contact'
  match 'send_contact', :to => 'application#send_contact'
  
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
  match 'videos/:id', :to => 'chapters#show', :as => "video"
  
  match 'events/partner_programs/:id', :to => 'events#partner_programs', :as => 'partner_program'
  

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
      resources :notes, :only => [:new, :create]
    end

    resources :bhsi_applications do
      member do
        # pages
        get :notes
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
      end
      resources :notes, :only => [:new, :create]
      resources :event_photos, :only => [:new, :create]
    end

    resources :sponsors do
      member do
        # pages
        get :notes
      end
      resources :notes, :only => [:new, :create]
    end

    resources :sponsorship_levels do
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
      resources :notes, :only => [:new, :create]
    end
  
    resources :venues
  
  end
  
  

end
