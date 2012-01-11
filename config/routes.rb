CraigsAdmin::Application.routes.draw do
  
  # the Site
  # ---------------------------------------------------------------------------------------------------------
  
  root :to => 'application#index'

  # we load in this dynamic content after the page loads, this allows us to cache the entire front end of the website
  match 'account_links', :to => 'application#account_links'

  # website pages
  match 'team', :to => 'application#team'
  match 'search', :to => 'application#search'
  match 'videos', :to => 'application#videos'
  
  # about pages / sug-pages
  match 'about', :to => 'Application::About#index'
  match 'about/staff', :to => 'Application::About#staff'
  match 'about/staff/:id', :to => 'Application::About#staff'
  match 'about/volunteer', :to => 'Application::About#volunteer'
  
  # community pages / sub-pages
  match 'community', :to => 'Application::Community#index'  
  match 'partners', :to => 'Application::Partners#index'
  match 'partners/integrated-partnerships', :to => 'Application::Partners#integrated_partnerships'
  match 'sponsors', :to => 'Application::Sponsors#index'
  
  # Events: Talks, Mega Talks, Labs, Partner Programs...
  match 'events', :to => 'Application::Events#index'

  match 'events/talks', :to => 'Application::Talks#talks'
  match 'events/talks/:id', :to => 'Application::Talks#talks', :as => "talk"

  match 'events/mega-talks', :to => 'Application::Talks#mega_talks'
  match 'events/mega-talks/:id', :to => 'Application::Talks#mega_talks', :as => "megatalk"
  
  match 'events/labs', :to => 'Application::Events#labs'
  match 'events/labs/:id', :to => 'Application::Events#labs', :as => "event_lab"

  match 'events/partner-programs', :to => 'Application::Events#partner_programs'
  match 'events/partner-programs/:id', :to => 'Application::Events#partner_programs', :as => "event_partnerprogram"

  # legalese 
  match 'privacy', :to => 'application#privacy'
  match 'terms', :to => 'application#terms'
    
  # users homepage
  match 'dashboard' => 'application#dashboard', :as => 'user_root'
  
  # authentication for the website, uses Devise and Omniauth for facebook and twitter connect
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  match 'account', :to => 'users#index'
  
  resources :users do
    member do
      put :disconnect_facebook
      put :disconnect_twitter
      put :complete_account_update
    end
  end
  
  resources :topics, :only => [:index, :show]
  resources :speakers, :only => [:index, :show], :controller => 'Application::Speakers'
  resources :volunteer, :only => [:index, :show], :controller => "Application::Volunteer"
  resources :partner, :only => [:index, :show], :controller => "Application::Partner"
  resources :sponsors, :only => [:index, :show], :controller => "Application::Sponsors"

  
  
  # the Admin                                                                   (http://www.domain.com/admin)
  # ---------------------------------------------------------------------------------------------------------
  namespace :admin do
  
    root :to => 'admin#index'

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
      end
      resources :notes, :only => [:new, :create]
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
      end
      resources :notes, :only => [:new, :create]
      resources :chapters, :only => [:new, :create]
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
      end
      resources :notes, :only => [:new, :create]
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
        # notes have attachemts, which are passed through the application because the files are not publically availiable through the Internet
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
