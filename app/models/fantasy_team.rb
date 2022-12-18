class FantasyTeam < ApplicationRecord
  # has_many :users
  has_many :rosters
  has_many :players, through: :rosters
end
