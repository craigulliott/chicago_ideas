CraigsAdmin::Application.routes.draw do
  
  # the Site
  # ---------------------------------------------------------------------------------------------------------
  
  root :to => 'application#index'

  # we load in this dynamic content after the page loads, this allows us to cache the entire front end of the website
  match 'account_links', :to => 'application#account_links'

  # website pages
  # ----------------------------------------------------------------
  match 'search', :to => 'application#search'

  # legalese 
  match 'privacy', :to => 'application#privacy'
  match 'terms', :to => 'application#terms'

  # news about CIW
  resources :press_clippings, :only => [:index]
  
  # sponsors and partners
  # ----------------------------------------------------------------
  resources :sponsors, :only => [:index]
  resources :partners, :only => [:index]

  # users
  # ----------------------------------------------------------------
  # user account page
  match 'dashboard' => 'application#dashboard', :as => 'user_root'
  
  # authentication for the website, uses Devise and Omniauth for facebook and twitter connect
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  match 'account', :to => 'users#index'
  
  
  resources :users do
    member do
      # pages
      get :volunteer # form to sign up to be a volunteer
      # actions
      put :disconnect_facebook
      put :disconnect_twitter
      put :complete_account_update
    end
  end
  
  
  # teams members and speakers are both a type of user, so are handled by the users controller
  match 'team_members', :to => 'users#list_team_members'
  match 'team_members/:id', :to => 'users#team_member', :as => "team_member"
  match 'speakers', :to => 'users#list_speakers'
  match 'speakers/page/:page', :to => 'users#list_speakers'
  match 'speakers/:id', :to => 'users#speaker', :as => "speaker"
  
  
  # Static Pages
  match 'about', :to => 'application#about'
  match 'volunteer', :to => 'application#volunteer'
  match 'special_programs', :to => 'application#special_programs_awards'
  match 'community', :to => 'application#community'
  
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
  

  # all videos are of chapters, so pass to the chapter controller
  match 'videos', :to => 'chapters#index'
  match 'videos/:id', :to => 'chapters#show', :as => "video"
  
  match 'events/partner_programs/:id', :to => 'events#partner_programs'
  

  # the Admin                                                                   (http://www.domain.com/admin)
  # ---------------------------------------------------------------------------------------------------------
  namespace :admin do
  
    root :to => 'admin#index'

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
  
  # the API                                                                          (http://api.domain.com/)
  # ---------------------------------------------------------------------------------------------------------
  constraints :subdomain => "api" do
    scope :module => "api", :as => "api" do
  
      # the documentation
      root :to => 'documentation#documentation'
  
      resources :speaker, :only => [:list, :show] do
        # search for speakers
        get :search, :on => :collection
        # resources
        resources :talks, :only => [:list, :show]
      end
  
    end
  end
    

end
