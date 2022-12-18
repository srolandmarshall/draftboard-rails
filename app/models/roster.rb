class Roster < ApplicationRecord
  belongs_to :player
  belongs_to :fantasy_team
end
