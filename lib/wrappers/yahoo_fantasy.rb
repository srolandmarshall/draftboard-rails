module Wrappers
  class YahooFantasy
    def client_id
      @client_id ||= Rails.application.credentials&.yahoo[:client_id] || ENV['YAHOO_CLIENT_ID']
    end

    def client_secret
      @client_secret ||= Rails.application.credentials&.yahoo[:client_secret] || ENV['YAHOO_CLIENT_SECRET']
    end

    def yahoo_auth_code
      @yahoo_auth_code ||= Rails.application.credentials&.yahoo[:access_code] || ENV['yahoo_auth_code']
    end

    def request_auth_url
      url = 'https://api.login.yahoo.com/oauth2/request_auth'
      url += "?client_id=#{client_id}"
      url += '&redirect_uri=oob'
      url += '&response_type=code'
    end

    def fantasy_api_url
      'https://fantasysports.yahooapis.com/fantasy/v2/'
    end

    def get_oauth
      auth_header = Base64.strict_encode64("#{client_id}:#{client_secret}")
      body = {
        grant_type: 'authorization_code',
        redirect_uri: 'oob',
        client_id:,
        client_secret:,
        code: yahoo_auth_code
      }.to_query

      # Make a x-www-form-urlencoded request to get a request token
      response = HTTParty.post('https://api.login.yahoo.com/oauth2/get_token',
                               headers: {
                                 'Authorization' => "Basic #{auth_header}",
                                 'Content-Type' => 'application/x-www-form-urlencoded'
                               },
                               body:,
                               timeout: 1000)
      File.open('public/yahoo_oauth.json', 'w') { |file| file.write(response.parsed_response.to_json) }
    end

    def refresh_token
      refresh_token = oauth_data['refresh_token']
      auth_header = Base64.strict_encode64("#{client_id}:#{client_secret}")

      body = {
        grant_type: 'refresh_token',
        refresh_token:,
        redirect_uri: 'oob',
        client_id:,
        client_secret:
      }.to_query

      response = HTTParty.post('https://api.login.yahoo.com/oauth2/get_token',
                               headers: { 'Authorization' => "Basic #{auth_header}", 'Content-Type' => 'application/x-www-form-urlencoded' }, body:, timeout: 1000)

      File.open('public/yahoo_oauth.json', 'w') { |file| file.write(response.parsed_response.to_json) }
    end

    def oauth_data
      path = 'public/yahoo_oauth.json'
      return JSON.parse(File.read(path)) if File.exist?(path)

      raise 'No oauth data found'
    end

    def access_token
      oauth_data['access_token']
    end

    def get_players
      params = {
        format: 'json',
        league: 'nfl'
      }
      headers = {
        'Authorization' => "Bearer #{access_token}"
      }

      response = HTTParty.get("#{fantasy_api_url}players",
                              headers:, query: params, timeout: 1000)
    end
  end
end

# Wrappers::YahooFantasy.new.request_auth_url
# Wrappers::YahooFantasy.new.get_oauth
# yf = Wrappers::YahooFantasy.new
