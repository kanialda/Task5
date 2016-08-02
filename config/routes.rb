Rails.application.routes.draw do

  resources :articles do
    collection { post :import }
  end
  
  resources :comments
  get "sign_up" => "users#new", :as => "sign_up"
  resources :users
  resources :sessions

  get "login" => "sessions#new", :as => "login"
  post "create" => "sessions#create"
  get "logout" => "sessions#logout", :as => "logout"

  get "reset-password" => "sessions#reset_password", :as => "reset_password"
  post "find-reset-password" => "find_reset_password", :as => "find_reset_password"
  get "reset-password/:token/edit" => "sessions#reset_password_edit", :as => "reset_password_edit"
  post "reset-password-process/:token" => "sessions#reset_password_process", :as => "reset_password_process"
  get "download/:id" => "articles#download", :as => "download"

  root 'articles#index'
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
