class Draft < ApplicationRecord
  belongs_to :fantasy_league
  has_many :fantasy_teams, through: :fantasy_league

  has_many :draft_picks
  has_many :players, through: :draft_picks

  def available_players
    Player.not_drafted(id)
  end

  def reset!
    draft_picks.destroy_all
    @order_with_teams = nil
    update(current_round: 1, current_pick: 1, order: generate_order)
    order_with_teams # sets the memoized @order_with_teams
  end

  # generates an array of hashes w/ `round` number and `order`, an array of fantasy team IDs representing the draft order
  def generate_order
    order = fantasy_teams.shuffle.map(&:id)
    (1..roster_size).map do |i|
      { 'round': i, 'order': i.odd? ? order : order.reverse }
    end
  end

  # generates a hash of hashes with the key being the round and the value being an array of hashes with the key being the team ID and the value being nil
  # this is more friendly for use in js state
  def initialize_state
    (1..roster_size).map do |i|
      { i => order.map { |team_id| { team_id => nil } } }
    end
  end

  def reset_firestore_state!
    FirestoreService.set_draft_state!(id, initialize_state)
  end

  def by_round; end

  def generate_state
    # this creates an array similar to #initialize_state, but provides player ids if there is a DraftPick
    order.map do |round|
      { round['round'] => round['order'].map do |team_id|
        { team_id => draft_pick_lookup({ round: round['round'], fantasy_team_id: team_id }) }
      end }
    end
  end

  def draft_pick_lookup(opts = {})
    pick = draft_picks.find_by(opts)
    pick&.player_id
  end

  def set_firestore_state!
    FirestoreService.set_draft_state!(id, generate_state)
  end

  def firestore_state
    FirestoreService.draft_state(id)
  end

  def order_with_teams
    # creates a 2d array, with the inner array an array of hashes, that represent the draft order
    @order_with_teams ||= order.map do |round|
      round['order'].map.with_index do |team_id, i|
        { round: round['round'], team: FantasyTeam.find(team_id), pick_number: i + 1 }
      end
    end
  end

  def current_pick_index
    current_pick.to_i - 1
  end

  def current_round_index
    current_round.to_i - 1
  end

  def current_round_order
    order[current_round_index]['order']
  end

  def current_team
    fantasy_teams.find_by(id: current_round_order[current_pick_index])
  end

  def team_by_pick(pick)
    fantasy_teams.find_by(id: order[pick.to_i - 1])
  end

  def increment_round!
    current_round + 1 > roster_size ? update(current_round: 1) : end_draft!
  end

  def increment_pick!
    # add 1 to current_pick, unless it's the last pick of the round, then increment the round
    if current_pick + 1 > roster_size
      increment_round!
      update(current_pick: 1) if active
    else
      update(current_pick: current_pick + 1)
    end
  end

  def decrement_pick!
    update(current_pick: current_pick - 1)
  end

  def make_pick(player_id, fantasy_team_id = current_team.id, pick_number = current_pick)
    draft_picks.create(pick_number:, player_id:, fantasy_team_id:)
    increment_pick! if pick_number == current_pick
  end

  def undo_pick!
    draft_picks.last.destroy
    decrement_pick!
  end

  def end_draft!
    update(active: false)
  end
end
