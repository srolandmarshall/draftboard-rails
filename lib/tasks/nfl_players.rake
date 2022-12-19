require 'httparty'

desc 'Get all NFL player urls'
task :nfl_player_urls do
  starting_url = 'https://sports.core.api.espn.com/v2/sports/football/leagues/nfl/athletes?limit=1000&active=true'
  @url = starting_url
  @player_urls = []
  @response = HTTParty.get(starting_url)
  current_page = 1

  if @response.success?
    original_response = @response.parsed_response
    num_pages = original_response['pageCount'].to_i
    while current_page <= num_pages
      @response = HTTParty.get(@url)
      # cycle through the pages until all player_url have been collected
      @player_urls += @response.parsed_response['items'].map { |player| player['$ref'] }
      # get the next page of players
      current_page += 1
      @url = starting_url + "&page=#{current_page + 1}"
      puts "Getting next page of players: Page \##{current_page}"
    end
  else
    # Handle error
    puts "Error: #{response.code}"
  end

  File.write('public/nfl_player_urls.txt', @player_urls)
end

desc 'Get teams by URL'
task nfl_teams_by_urls: :environment do
  url = 'https://sports.core.api.espn.com/v2/sports/football/leagues/nfl/teams?limit=32'
  HTTParty.get(url).parsed_response['items'].each do |item|
    team_url = item['$ref']
    team_response = HTTParty.get(team_url)
    Team.find_or_create_by(team_name: team_response['displayName'], url: team_url)
  end
end

desc 'Create all NFL players by URL'
task nfl_players_by_urls: :environment do
  file = File.open('public/nfl_player_urls.txt', 'r')
  eval(file.read).each do |player_url|
    # puts the URL in the Player URL column
    player = Player.find_or_create_by(url: player_url)
    puts "Creating player by: #{player_url}"
    player.save
  end
end

desc 'Create all NFL players by data from URL'
task nfl_player_data: :environment do
  Player.with_url_no_data.each do |player|
    url = player.url
    response = HTTParty.get(url)
    # parse data from response
    player.update(data: response.parsed_response)
    puts "Populating Player Data: Player \##{player.id}"
    player.save!
  rescue StandardError => e
    byebug
  end
end

desc 'Create all NFL teams by data from URL'
task nfl_team_data: :environment do
  Team.all.each do |team|
    url = team.url
    response = HTTParty.get(url)
    # parse data from response
    team_name = response.parsed_response['name']
    location = response.parsed_response['location']
    abbreviation = response.parsed_response['abbreviation']
    team.update(team_name:, location:, abbreviation:)
  end
end
