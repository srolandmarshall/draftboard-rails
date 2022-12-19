class DraftPick < ApplicationRecord
  belongs_to :draft
  belongs_to :player
  belongs_to :fantasy_team, optional: true
end
