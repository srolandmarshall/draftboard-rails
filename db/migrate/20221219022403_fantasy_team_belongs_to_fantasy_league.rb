class FantasyTeamBelongsToFantasyLeague < ActiveRecord::Migration[7.0]
  def change
    # fantasy team belongs to a fantasy league, allows null
    add_reference :fantasy_teams, :fantasy_league, foreign_key: true, null: true
  end
end
