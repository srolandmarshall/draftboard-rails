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

  # by league scope
  scope :by_league, ->(league_name) { where(league_name:) }

  def full_name
    "#{first_name} #{last_name}"
  end

  def draftboard_display
    "#{full_name} (#{team.abbreviation}) - #{position}"
  end

  def attributes_without_data
    attributes.except('data')
  end

  # Returns Google::Cloud::Firestore::DocumentReference for the player
  def firestore_document
    FirestoreService::Players.player_reference(id)
  end
end
