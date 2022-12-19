class Player < ApplicationRecord
  belongs_to :team, optional: true
  has_many :rosters
  has_many :fantasy_teams, through: :rosters

  # with URL but no data
  scope :with_url_no_data, -> { where.not(url: nil).where(data: nil) }
  scope :with_data, -> { where.not(data: nil) }
  scope :with_no_data, -> { where(data: nil) }

  # players that have been drafted in a specific draft
  scope :drafted, ->(draft_id) { where(id: DraftPick.where(draft_id:).pluck(:player_id)) }

  # where not drafted in that draft
  scope :not_drafted, ->(draft_id) { where.not(id: DraftPick.where(draft_id:).pluck(:player_id)) }

  def full_name
    "#{first_name} #{last_name}"
  end

  def draftboard_display
    "#{full_name} (#{team.abbreviation}) - #{position}"
  end
end
