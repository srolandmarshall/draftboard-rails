class FantasyTeam < ApplicationRecord
  has_many :draft_picks
  has_many :players, through: :draft_picks
  belongs_to :fantasy_league
  has_many :drafts, through: :fantasy_league
end
