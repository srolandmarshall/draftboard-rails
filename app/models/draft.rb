class Draft < ApplicationRecord
  belongs_to :fantasy_league
  has_many :fantasy_teams, through: :fantasy_league

  has_many :draft_picks
  has_many :players, through: :draft_picks

  def generate_order
    # generate a hash of a snake draft order from the fantasy teams belonging to the league
    # the order is a function of roster_size each draft has
    # each team will have a number of picks equal to the roster_size
    # each round will be a mirror of the previous round
    # randomly select the order of the first round
    order = fantasy_teams.shuffle
    order_hash = {}
    num_of_picks = roster_size * fantasy_teams.count
    pick = 1
    while pick <= num_of_picks
      order.each do |team|
        order_hash[pick] = team.id
        pick += 1
      end
      order.reverse!
    end
    order_hash
  end

  def generate_order!
    draft_picks.destroy_all
    update(order: generate_order)
  end

  def current_team
    fantasy_teams.find_by(id: order[current_pick.to_s])
  end

  def team_by_pick(pick)
    fantasy_teams.find_by(id: order[pick.to_s])
  end

  def increment_pick!
    # will increment the current_pick
    update(current_pick: current_pick + 1)
  end
end
