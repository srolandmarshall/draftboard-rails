class GeneratePlayerAttributesFromData < ActiveRecord::Migration[7.0]
  def change
    Player.with_data.each do |player|
      data = player.data
      player.team = Team.find_by(url: data['team']['$ref'])
      player.first_name = data['firstName']
      player.last_name = data['lastName']
      player.jersey = data['jersey'].to_i
      player.position = data['position']['abbreviation']
      player.save!
    end
  end
end
