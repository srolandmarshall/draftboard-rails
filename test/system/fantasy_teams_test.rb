require "application_system_test_case"

class FantasyTeamsTest < ApplicationSystemTestCase
  setup do
    @fantasy_team = fantasy_teams(:one)
  end

  test "visiting the index" do
    visit fantasy_teams_url
    assert_selector "h1", text: "Fantasy teams"
  end

  test "should create fantasy team" do
    visit fantasy_teams_url
    click_on "New fantasy team"

    click_on "Create Fantasy team"

    assert_text "Fantasy team was successfully created"
    click_on "Back"
  end

  test "should update Fantasy team" do
    visit fantasy_team_url(@fantasy_team)
    click_on "Edit this fantasy team", match: :first

    click_on "Update Fantasy team"

    assert_text "Fantasy team was successfully updated"
    click_on "Back"
  end

  test "should destroy Fantasy team" do
    visit fantasy_team_url(@fantasy_team)
    click_on "Destroy this fantasy team", match: :first

    assert_text "Fantasy team was successfully destroyed"
  end
end
