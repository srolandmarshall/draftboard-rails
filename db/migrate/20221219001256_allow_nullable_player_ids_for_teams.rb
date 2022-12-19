class AllowNullablePlayerIdsForTeams < ActiveRecord::Migration[7.0]
  def change
    change_column_null :teams, :players_id, true
  end
end
