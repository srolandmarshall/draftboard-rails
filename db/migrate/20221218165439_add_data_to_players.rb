class AddDataToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :data, :jsonb, null: true, default: nil
  end
end
