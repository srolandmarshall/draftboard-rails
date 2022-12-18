class ChangeFantasyLeagueDescriptionToText < ActiveRecord::Migration[7.0]
  def change
    change_column :fantasy_leagues, :description, :text
  end
end
