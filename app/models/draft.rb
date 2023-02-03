class Draft < ApplicationRecord
  belongs_to :fantasy_league
  has_many :fantasy_teams, through: :fantasy_league

  has_many :draft_picks
  has_many :players, through: :draft_picks

  def available_players
    Player.not_drafted(id)
  end

  def pick
    { round: current_round, pick_number: current_pick }
  end

  def reset!
    draft_picks.destroy_all
    @order_with_teams = nil # reset memoized var
    update(current_round: 1, current_pick: 1, order: generate_order)
    order_with_teams # sets the memoized var
    set_firestore_state!
  end

  # generates, but does not set, a fresh order
  # order is an array of hashes w/ `round` number and `order`, an array of fantasy team IDs representing the draft order
  def generate_order
    o = fantasy_teams.shuffle.map(&:id)
    (1..roster_size).map do |i|
      { 'round': i, 'order': i.odd? ? o : o.reverse }
    end
  end

  # this creates a hash with round as the key, and the value is an array of hashes with fantasy_team_id and draft_pick_lookup
  def generate_state
    order.each_with_object({}) do |round, state|
      state[round['round']] = round['order'].map do |team_id|
        { team_id => draft_pick_lookup(fantasy_team_id: team_id, round: round['round']) }
      end
    end
  end

  # returns id of player if there is a draft pick for the given options, otherwise returns nil
  def draft_pick_lookup(opts = {})
    pick = draft_picks.find_by(opts)
    pick&.player_id
  end

  def set_firestore_state!(state = generate_state)
    FirestoreService::Drafts.set_state!(id, state)
  end

  def firestore_state
    FirestoreService::Drafts.state(id)
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
    current_round + 1 > roster_size ? end_draft! : update(current_round: current_round + 1)
  end

  def increment_pick!
    # add 1 to current_pick, unless it's the last pick of the round, then increment the round
    if current_pick + 1 > fantasy_teams.count
      increment_round!
      update(current_pick: 1) if active
    else
      update(current_pick: current_pick + 1)
    end
  end

  def make_pick!(draft_pick)
    round = draft_pick.round
    pick_number = draft_pick.pick_number
    player_id = draft_pick.player_id
    fantasy_team_id = draft_pick.fantasy_team_id
    increment_pick! if pick == { round:, pick_number: }
    FirestoreService::Drafts.set_pick!(draft_id: id, round:, pick_number:, player_id:, fantasy_team_id:)
  end

  def decrement_pick!
    update(current_pick: current_pick - 1)
  end

  def undo_pick!
    draft_picks.last.destroy
    decrement_pick!
  end

  def start_draft!
    update(active: true)
  end

  def end_draft!
    update(active: false)
  end
end
