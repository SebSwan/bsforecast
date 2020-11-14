Rails.application.routes.draw do
  root to: 'spots#wizard', as: :wizard
  get 'list', to: 'spots#list', as: :list
  get 'show/:id', to: 'spots#show', as: :show
  get 'option', to: 'spots#options', as: :options
  get 'new', to: 'spots#new', as: :new
  # For details on the DSL available wizardthin this file, see https://guides.rubyonrails.org/routing.html
end
