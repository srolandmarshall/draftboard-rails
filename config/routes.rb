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
  resources :fantasy_teams
  resources :fantasy_leagues do
    resources :teams, controller: 'fantasy_teams'
  end
end
