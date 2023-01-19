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
    update(current_pick: 1, order: generate_order)
  end

  # generates an array of fantasy team IDs that represents the draft order
  def generate_order
    order = fantasy_teams.shuffle.map(&:id)
    order_array = []
    roster_size.times do |i|
      order_array += i.odd? ? order : order.reverse
    end
    order_with_teams # sets the memoized @order_with_teams
    order_array
  end

  def order_with_teams
    @order_with_teams ||= order.map.with_index do |team_id, index|
      { number: index + 1, team: FantasyTeam.find_by(id: team_id) }
    end
  end

  def current_pick_index
    current_pick.to_i - 1
  end

  def current_team
    fantasy_teams.find_by(id: order[current_pick_index])
  end

  def team_by_pick(pick)
    fantasy_teams.find_by(id: order[pick.to_i - 1])
  end

  def increment_pick!
    update(current_pick: current_pick + 1)
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
end
