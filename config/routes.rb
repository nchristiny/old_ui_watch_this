Rails.application.routes.draw do
  root 'home#index'
  get 'signup'  => 'users#new'
  get 'login' => 'sessions#create'

  # Creating friendly URLs and caching of pagination
  concern :paginatable do
    get '(page/:page)', :action => :index, :on => :collection, :as => ''
  end

  resources :films, only: [:index, :show], :concerns => :paginatable
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :recommendations, only: [:new, :create, :index, :show, :destroy]
end
