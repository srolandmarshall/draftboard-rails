class Player < ApplicationRecord
  belongs_to :team, optional: true
  has_many :rosters
  has_many :fantasy_teams, through: :rosters

  # with URL but no data
  scope :with_url_no_data, -> { where.not(url: nil).where(data: nil) }
  scope :with_data, -> { where.not(data: nil) }
  scope :with_no_data, -> { where(data: nil) }
end
