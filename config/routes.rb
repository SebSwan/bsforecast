Rails.application.routes.draw do

root to: "wizards#list", as: :wizard
get "option", to: "wizards#option", as: :option
get "list", to: "spots#list", as: :list
get "new", to: "spots#new", as: :new
get "show", to:"spots#show", as: :show
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
