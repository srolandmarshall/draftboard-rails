class Player < ApplicationRecord
  belongs_to :team
  has_many :rosters
  has_many :fantasy_teams, through: :rosters
end
