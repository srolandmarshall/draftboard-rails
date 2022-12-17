class CreateFantasyLeagues < ActiveRecord::Migration[7.0]
  def change
    create_table :fantasy_leagues do |t|
      # has many drafts
      t.references :draft, foreign_key: true
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
