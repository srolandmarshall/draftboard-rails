class Draft < ApplicationRecord
  belongs_to :fantasy_league
  has_many :fantasy_teams, through: :fantasy_league

  has_many :draft_picks
  has_many :players, through: :draft_picks

  def available_players
    Player.not_drafted(id)
  end

  def reset
    draft_picks.destroy_all
    update(current_pick: 1, order: generate_order)
  end

  def generate_order
    # generate a hash of a snake draft order from the fantasy teams belonging to the league

    # randomly select the order of the first round
    order = fantasy_teams.shuffle
    order_hash = {}
    # each team will have a number of picks equal to the roster_size
    # the order is a function of roster_size each draft has
    num_of_picks = roster_size * fantasy_teams.count
    pick = 1
    while pick <= num_of_picks
      order.each do |team|
        order_hash[pick] = team.id
        pick += 1
      end
      # each round will be a mirror of the previous round
      order.reverse!
    end
    order_hash
  end

  def order_with_teams
    # for each pair in the order hash, find the team and return a hash of the pick and team
    order.map do |pick, team_id|
      { pick:, team: FantasyTeam.find_by(id: team_id) }
    end
  end

  def current_team
    fantasy_teams.find_by(id: order[current_pick.to_s])
  end

  def team_by_pick(pick)
    fantasy_teams.find_by(id: order[pick.to_s])
  end

  def increment_pick!
    update(current_pick: current_pick + 1)
  end
end
