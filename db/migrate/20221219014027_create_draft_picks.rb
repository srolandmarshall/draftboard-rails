class CreateDraftPicks < ActiveRecord::Migration[7.0]
  def change
    create_table :draft_picks do |t|
      # joins a draft and a player to a fantasy team
      t.belongs_to :draft, null: false, foreign_key: true
      t.belongs_to :player, null: false, foreign_key: true
      t.belongs_to :fantasy_team, foreign_key: true

      t.timestamps
    end
  end
end
