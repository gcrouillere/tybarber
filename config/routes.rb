Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  devise_for :users, :controllers => {:registrations => "app_specific_registration/registrations", omniauth_callbacks: 'users/omniauth_callbacks'}
  mount Attachinary::Engine => "/attachinary"

  scope do
    resources :ceramiques, path: ENV['MODEL'], only: [:create, :index, :destroy, :show, :update]
  end

  resources :orders, only: [:show, :create, :destroy] do
    resources :payments, only: [:new, :create]
  end

  resources :lessons, only: [:new, :create, :destroy, :show]

  resources :users, only: [:update, :create]

  resources :articles, only: [:new, :index, :show, :update, :create, :destroy]

  #Stages
  get '/stage_confirmation', to: 'lessons#stage_confirmation'
  get '/stage_payment_confirmation', to: 'lessons#stage_payment_confirmation'

  #Pages
  get '/confirmation', to: 'pages#confirmation'
  get '/agenda', to: 'pages#agenda'
  get '/professionnels', to: 'pages#professionnels'
  get '/presse', to: 'pages#presse'
  get '/sites_partenaires', to: 'pages#sites_partenaires'
  get '/cgv', to: 'pages#cgv'
  get '/atelier', to: 'pages#atelier'
  get '/morta', to: 'pages#morta'
  get '/la_briere', to: 'pages#la_briere'
  get '/temoignages', to: 'pages#temoignages'
  get '/sur_mesure', to: 'pages#sur_mesure'
  get '/contact', to: 'pages#contact'
  get '/cgv', to: 'pages#cgv'
  get '/legal', to: 'pages#legal'
  get '/google906057532e2dbb7e', to: 'pages#google906057532e2dbb7e'
  get '/robots.txt', to: 'pages#robots', :defaults => { :format => 'txt' }

  #Sitemap
  get 'sitemap.xml', :to => 'sitemap#sitemap', :defaults => { :format => 'xml' }

  #Subscribe
  post '/user-subscribe', to: "users#subscribe"

  #Root
  root to: 'pages#home'

  #Errors
  get "/404", to: "errors#error_404"

  #API
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :shipping_categories, only: [:show]
      resources :promos, only: [:show]
    end
  end

  #Position management through JS
  get '/ceramiques/update_positions_after_swap_in_admin', to: "ceramiques#update_positions_after_swap_in_admin"

end
