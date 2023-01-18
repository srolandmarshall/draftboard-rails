Rails.application.routes.draw do
  resources :draft_picks
  resources :teams
  # route for stimulus autocomplete
  get '/players/search', to: 'players#search', as: 'search_players'
  resources :players
  resources :drafts
  # create a "start_draft_path" route that turns active to true
  put '/drafts/:id/start_draft', to: 'drafts#start_draft', as: 'start_draft'
  post '/drafts/:id/reset', to: 'drafts#reset', as: 'reset_draft'
  resources :fantasy_leagues do
    # nested resources for fantasy_leagues/teams, which is an alias for fantasy_teams
    resources :teams, controller: 'fantasy_teams'
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
