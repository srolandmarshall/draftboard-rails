class AddLeagueNameToPlayer < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :league_name, :string
    Player.update_all(league_name: 'NFL')
  end
end
