Application::Application.routes.draw do
  # Administration related routes.
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config
  put 'admin/vehicles/:id/approve', to: 'admin/vehicles#approve'

  # match '/admin/global_select_options/hello' => "admin/global_select_options#helloo",:as=>:hello
  get '/admin/global_select_options/:locale/get_locale'=> "admin/global_select_options#get_locale"
  get '/admin/global_select_options/:locale/update_global_options'=> "admin/global_select_options#update_global_options"

  get '/admin/prewritten_version_comments/:locale/get_prewritten_comments'=> "admin/prewritten_version_comments#get_prewritten_comments"
  get '/admin/prewritten_version_comments/:locale/update_prewritten_comments'=> "admin/prewritten_version_comments#update_prewritten_comments"

  root to: 'application#dashboard'
  get '/dashboard', to: 'application#dashboard', as: 'dashboard'
  scope '/profiles/:profile_id' do
    get 'pictures',     to: 'application#dashboard'
    get 'pictures/new', to: 'profiles/pictures#new'
  end


  # Sessions related routes.
  post   '/sign_in',                    to: 'sessions#create'
  delete '/sign_out',                   to: 'sessions#destroy'
  get   '/facebook_sessions',          to: 'facebook_sessions#new'
  get    '/facebook_sessions/callback', to: 'facebook_sessions#callback'


  get '/my/favorites', to: 'favorites#my_index'
  match '/my/(*foo)', to: 'application#dashboard', defaults: {format: :html}

  get '/users/:id',                        to: 'application#dashboard'
  get 'albums',                            to: 'application#dashboard'
  get 'albums/:id',                        to: 'application#dashboard'
  get 'myy_cloud',                         to: 'application#dashboard'
  get 'myy_cloud/:tab',                    to: 'application#dashboard'


  put '/users/:id/update_avatar',    to: 'users#update_avatar'
  put '/users/:id/unbind_facebook_account', to: 'users#unbind_facebook_account'


  get '/vehicles/new',                      to: 'application#dashboard'
  get '/vehicles/search',                   to: 'application#dashboard'
  get '/vehicles/cars/search',              to: 'application#dashboard'
  get '/vehicles/bikes/search',             to: 'application#dashboard'
  put '/vehicles/:id/update_avatar',        to: 'vehicles#update_avatar'
  put '/vehicles/:id/update_mosaic_avatar', to: 'vehicles#update_mosaic_avatar'

  get "vehicles/:vehicle_id/performances",   to: "application#dashboard"
  get "vehicles/:vehicle_id/specifications", to: "application#dashboard"
  get "vehicles/:vehicle_id/modifications",  to: "application#dashboard"
  get "vehicles/:vehicle_id/identification", to: "application#dashboard"
  get "vehicles/:vehicle_id/identification/edit", to: "application#dashboard"
  get "vehicles/:vehicle_id/collage/:collage_id", to: "application#dashboard"
  get "vehicles/:vehicle_id/comments",            to: "application#dashboard"

  get '/comparison_tables',     to: 'application#dashboard'
  get '/comparison_tables/:id', to: 'application#dashboard'

  scope '/api', defaults: { format: 'json' } do
    resources :users, only: [:show, :update] do
      resources :vehicles, only: [:create, :show, :index, :update, :destroy]
    end
    resources :news_feeds, only: [:index]
    resources :followings, only: [:create, :index, :destroy]
    resources :followers, only: [:index]
    resources :versions, only: [:create, :update, :show] do
      resource :data_sheet, only: :show
      resources :properties, only: [:create, :update], controller: "version_properties"
      resources :generations, only: [:index, :update]
      get  'prewritten_comments', :action => 'get_prewritten_comments',  :on => :collection
      post 'prewritten_comments', :action => 'post_prewritten_comments', :on => :collection
      get 'comments',             :action => 'comments',                 :on => :member
    end
    resources :version_attributes, only: [:show]

    resources :corrections, :only => [:create, :update, :index]

    resources :side_views, only: [:show, :index]
    resources :vehicles, only: [:show, :update, :destroy] do
      collection do
        match 'search', :via => [:get, :post]
      end
      resources :bookmarks, only: [:create, :destroy], controller: "vehicle_bookmarks"
      resources :modifications, only: [:index, :create, :destroy] do
        resources :services, only: [:create, :index, :update, :destroy]
      end
      resources :change_sets, only: [:create, :show, :update, :index, :destroy]
      get 'current_change_set', to: 'change_sets#current'
      resources :part_purchases, only: [:create, :update, :destroy]
      resources :ownerships, only: [:show, :update]
    end

    resources :modifications, only: [] do
      resources :properties, only: [:create, :destroy, :update], controller: "modification_properties"
    end

    resources :comparison_tables, only: [:create, :update, :show, :index] do
      member do
        post 'save'
        post 'like'
      end
    end

    resources :models, only: [] do
      resources :data_sheets, only: :index
      member do
        put :update_model_select_options
      end
    end

    post '/user_oppositions', to: 'user_oppositions#create'
    namespace :profiles do
      scope '/:profile_id' do
        get    'collages',     to: 'collages#index'
        post   'collages',     to: 'collages#create'
        put    'collages/:id', to: 'collages#update'
        delete 'collages/:id', to: 'collages#destroy'

        get    'pictures',     to: 'pictures#index'
        post   'pictures',     to: 'pictures#create'
        put    'pictures/:id', to: 'pictures#update'
        delete 'pictures/:id', to: 'pictures#destroy'
      end
      get 'pictures', to: 'pictures#index'
    end

    namespace :users do
      scope '/:user_id' do
        get 'pictures', to: 'pictures#index'
      end
    end

    resources :albums, only: [:show, :create, :update, :index] do
      resources :pictures, controller: 'profiles/pictures', only: [:index, :create]
    end
  end

  get '/users/:user_id/vehicles/:vehicle_id',                   to: 'application#dashboard'
  get '/users/:user_id/vehicles/:vehicle_id/galleries',         to: 'galleries#show'

  scope '/vehicles/:vehicle_id' do
    get    '/galleries',     to: 'galleries#index'
    post   '/galleries',     to: 'galleries#create'
    get    '/galleries/pictures',  to: 'galleries#gallery_pictures'
    get    '/galleries/:id', to: 'galleries#show'
    put    '/galleries/:id', to: 'galleries#update'
    delete '/galleries/:id', to: 'galleries#destroy'

    resources :modifications, only: [:index, :create, :update, :destroy] do
      resources :modification_parts, only: [:create, :update, :destroy]
    end
  end

  scope '/users/:user_id' do
    post '/comparison_tables',     to: 'comparison_tables#create'
    put  '/comparison_tables/:id', to: 'comparison_tables#update'

    match '(*foo)', to: 'application#dashboard'
  end

  scope '/api', defaults: { format: 'json' } do
    namespace :galleries do
      scope '/:gallery_id' do
        get    'collages',     to: 'collages#index'
        post   'collages',     to: 'collages#create'
        put    'collages/:id', to: 'collages#update'
        delete 'collages/:id', to: 'collages#destroy'

        get    'pictures',     to: 'pictures#index'
        post   'pictures',     to: 'pictures#create'
        get    'pictures/:id', to: 'pictures#show'
        put    'pictures/:id', to: 'pictures#update'
        delete 'pictures/:id', to: 'pictures#destroy'
      end
    end
  end

  scope '/api/pictures/:picture_id', defaults: { format: 'json' } do
    get    'comments',     to: 'comments#index'
    post   'comments',     to: 'comments#create'
    put    'comments/:id', to: 'comments#update'
    delete 'comments/:id', to: 'comments#destroy'
  end

  scope '/api/collages/:collage_id', defaults: { format: 'json' } do
    get    'cutouts',      to: 'cutouts#index'
    post   'cutouts',      to: 'cutouts#create'
    put    'cutouts/:id',  to: 'cutouts#update'
  end

  get  '/vendors', to: 'vendors#index'
  post '/vendors', to: 'vendors#create'

  get  '/parts', to: 'parts#index'
  post '/parts', to: 'parts#create'

  resources :users, only: [:create, :index] do
    get :confirm
    get :reset_password
    post :reset_password, action: 'execute_reset_password'
  end

  resources :passwords, only: [ :new, :create ]

  get '/bookmarklet', to: 'application#bookmarklet'


  # Favorites related routes.
  delete '/favorites/:id',             to: 'favorites#destroy'
  get    '/users/:user_id/favorites',  to: 'favorites#index'

  get    '/bookmarklet/favorites/new', to: 'bookmarklet/favorites#new'
  post   '/bookmarklet/favorites',     to: 'bookmarklet/favorites#create'

  get '/countries', to: 'countries#index', defaults: { format: 'json' }
  get '/locales',   to: 'locales#index'
  get '/units_systems', to: 'units_systems#index'

  get  '/models', to: 'models#index'
  post '/models', to: 'models#create'

  resources :brands, only: [:create, :index]

  resources :conversations, only: [:index, :show, :new, :create] do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end
end
