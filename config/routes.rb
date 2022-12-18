Rails.application.routes.draw do
  resources :fantasy_teams
  resources :players
  resources :drafts
  resources :fantasy_leagues
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
