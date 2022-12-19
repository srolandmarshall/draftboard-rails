require "application_system_test_case"

class DraftPicksTest < ApplicationSystemTestCase
  setup do
    @draft_pick = draft_picks(:one)
  end

  test "visiting the index" do
    visit draft_picks_url
    assert_selector "h1", text: "Draft picks"
  end

  test "should create draft pick" do
    visit draft_picks_url
    click_on "New draft pick"

    click_on "Create Draft pick"

    assert_text "Draft pick was successfully created"
    click_on "Back"
  end

  test "should update Draft pick" do
    visit draft_pick_url(@draft_pick)
    click_on "Edit this draft pick", match: :first

    click_on "Update Draft pick"

    assert_text "Draft pick was successfully updated"
    click_on "Back"
  end

  test "should destroy Draft pick" do
    visit draft_pick_url(@draft_pick)
    click_on "Destroy this draft pick", match: :first

    assert_text "Draft pick was successfully destroyed"
  end
end
