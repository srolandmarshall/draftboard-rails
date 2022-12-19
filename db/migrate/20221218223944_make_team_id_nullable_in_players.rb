class MakeTeamIdNullableInPlayers < ActiveRecord::Migration[7.0]
  def change
    change_column_null :players, :team_id, true
  end
end
