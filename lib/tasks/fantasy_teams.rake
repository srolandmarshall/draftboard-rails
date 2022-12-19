require 'faker'
desc 'Create a fantasy league'
task create_fantasy_league: :environment do
  league = FantasyLeague.create(name: Faker::Company.name)
  12.times do |_i|
    FantasyTeam.create(name: Faker::Team.name, fantasy_league: league)
  end
end
