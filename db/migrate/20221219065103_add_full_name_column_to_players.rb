class AddFullNameColumnToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :full_name, :string
    Player.where(full_name: nil).each do |player|
      puts "Updating #{player.data['displayName']}"
      player.update(full_name: player.data['displayName'])
    end
  end
end
