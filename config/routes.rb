Rails.application.routes.draw do

  root to: 'spots#wizard', as: :wizard
  get 'option', to: 'spots#options', as: :options

  resources :spots

  # get 'spots', to: 'spots#index', as: :index


  # get 'spots/new', to: 'spots#new', as: :new
  # post 'spots', to: 'spots#create'

  # get 'spots/show/:id/edit', to: 'spots#edit', as: :edit
  # patch 'spots/:id', to: 'spots#update', as: :update

  # get 'spots/show/:id', to: 'spots#show', as: :show

  # delete 'spots/:id', to: 'spots#destroy', as: :delete

  # For details on the DSL available wizardthin this file, see https://guides.rubyonrails.org/routing.html
end


