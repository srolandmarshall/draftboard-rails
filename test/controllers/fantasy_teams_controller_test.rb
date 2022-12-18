require "test_helper"

class FantasyTeamsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @fantasy_team = fantasy_teams(:one)
  end

  test "should get index" do
    get fantasy_teams_url
    assert_response :success
  end

  test "should get new" do
    get new_fantasy_team_url
    assert_response :success
  end

  test "should create fantasy_team" do
    assert_difference("FantasyTeam.count") do
      post fantasy_teams_url, params: { fantasy_team: {  } }
    end

    assert_redirected_to fantasy_team_url(FantasyTeam.last)
  end

  test "should show fantasy_team" do
    get fantasy_team_url(@fantasy_team)
    assert_response :success
  end

  test "should get edit" do
    get edit_fantasy_team_url(@fantasy_team)
    assert_response :success
  end

  test "should update fantasy_team" do
    patch fantasy_team_url(@fantasy_team), params: { fantasy_team: {  } }
    assert_redirected_to fantasy_team_url(@fantasy_team)
  end

  test "should destroy fantasy_team" do
    assert_difference("FantasyTeam.count", -1) do
      delete fantasy_team_url(@fantasy_team)
    end

    assert_redirected_to fantasy_teams_url
  end
end
