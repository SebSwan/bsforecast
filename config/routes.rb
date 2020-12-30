Rails.application.routes.draw do

  root to: 'spots#wizard', as: :wizard
  get 'option', to: 'spots#options', as: :options

  resources :spots

end


