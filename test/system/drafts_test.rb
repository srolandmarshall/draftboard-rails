require "application_system_test_case"

class DraftsTest < ApplicationSystemTestCase
  setup do
    @draft = drafts(:one)
  end

  test "visiting the index" do
    visit drafts_url
    assert_selector "h1", text: "Drafts"
  end

  test "should create draft" do
    visit drafts_url
    click_on "New draft"

    click_on "Create Draft"

    assert_text "Draft was successfully created"
    click_on "Back"
  end

  test "should update Draft" do
    visit draft_url(@draft)
    click_on "Edit this draft", match: :first

    click_on "Update Draft"

    assert_text "Draft was successfully updated"
    click_on "Back"
  end

  test "should destroy Draft" do
    visit draft_url(@draft)
    click_on "Destroy this draft", match: :first

    assert_text "Draft was successfully destroyed"
  end
end
