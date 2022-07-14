Rails.application.routes.draw do


  # custom path/controller for importing
  post '/upload', to: 'affiliation_importer#upload', as: 'process_import'

  resources :affiliations

  # authentication of login - logout
  devise_for :users

  # Defines the root path route ("/")
  root "affiliations#index"
end
