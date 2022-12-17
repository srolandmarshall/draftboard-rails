require "application_system_test_case"

class FantasyLeaguesTest < ApplicationSystemTestCase
  setup do
    @fantasy_league = fantasy_leagues(:one)
  end

  test "visiting the index" do
    visit fantasy_leagues_url
    assert_selector "h1", text: "Fantasy leagues"
  end

  test "should create fantasy league" do
    visit fantasy_leagues_url
    click_on "New fantasy league"

    click_on "Create Fantasy league"

    assert_text "Fantasy league was successfully created"
    click_on "Back"
  end

  test "should update Fantasy league" do
    visit fantasy_league_url(@fantasy_league)
    click_on "Edit this fantasy league", match: :first

    click_on "Update Fantasy league"

    assert_text "Fantasy league was successfully updated"
    click_on "Back"
  end

  test "should destroy Fantasy league" do
    visit fantasy_league_url(@fantasy_league)
    click_on "Destroy this fantasy league", match: :first

    assert_text "Fantasy league was successfully destroyed"
  end
end
