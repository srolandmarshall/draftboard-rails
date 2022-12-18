class CreateRosters < ActiveRecord::Migration[7.0]
  def change
    create_table :rosters do |t|
      t.belongs_to :fantasy_team, null: false, foreign_key: true
      t.belongs_to :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end
