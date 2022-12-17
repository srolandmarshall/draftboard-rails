class CreateFantasyTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :fantasy_teams do |t|
      t.string :name

      t.timestamps
    end
  end
end
