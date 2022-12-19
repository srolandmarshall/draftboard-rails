Rails.application.routes.draw do
  resources :draft_picks
  resources :teams
  resources :fantasy_teams
  resources :players
  resources :drafts
  # create a "start_draft_path" route that turns active to true
  put '/drafts/:id/start_draft', to: 'drafts#start_draft', as: 'start_draft'
  resources :fantasy_leagues
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
