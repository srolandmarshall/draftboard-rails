require "test_helper"

class FantasyLeaguesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @fantasy_league = fantasy_leagues(:one)
  end

  test "should get index" do
    get fantasy_leagues_url
    assert_response :success
  end

  test "should get new" do
    get new_fantasy_league_url
    assert_response :success
  end

  test "should create fantasy_league" do
    assert_difference("FantasyLeague.count") do
      post fantasy_leagues_url, params: { fantasy_league: {  } }
    end

    assert_redirected_to fantasy_league_url(FantasyLeague.last)
  end

  test "should show fantasy_league" do
    get fantasy_league_url(@fantasy_league)
    assert_response :success
  end

  test "should get edit" do
    get edit_fantasy_league_url(@fantasy_league)
    assert_response :success
  end

  test "should update fantasy_league" do
    patch fantasy_league_url(@fantasy_league), params: { fantasy_league: {  } }
    assert_redirected_to fantasy_league_url(@fantasy_league)
  end

  test "should destroy fantasy_league" do
    assert_difference("FantasyLeague.count", -1) do
      delete fantasy_league_url(@fantasy_league)
    end

    assert_redirected_to fantasy_leagues_url
  end
end
