class FantasyLeague < ApplicationRecord
  has_many :fantasy_teams
  has_many :drafts
end
