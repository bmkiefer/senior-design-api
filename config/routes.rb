DeviseExample::Application.routes.draw do

  namespace :api do
    namespace :v1 do
      devise_scope :user do
        post 'registrations' => 'registrations#create', :as => 'register'
        post 'sessions' => 'sessions#create', :as => 'login'
        delete 'sessions' => 'sessions#destroy', :as => 'logout'
      end
      get 'tasks' => 'tasks#index', :as => 'tasks'
      get 'my_organizations' => 'my_organizations#index'
      post 'admin_games' => 'admin_games#show'
      post 'admin_teams' => 'admin_teams#show'
      get 'admin_organizations' => 'admin_organizations#show'
      get 'games' => 'games#index'
      put 'admin_games' => 'admin_games#update'
      post 'my_favorites' => 'my_favorites#create'
      post 'search_organizations' => 'search_organizations#create'
    end
  end

  devise_for :users, :admins

  get '/token' => 'home#token', as: :token

  resources :home, only: :index
  resources :admins, only: :index

  root 'home#index'

end
