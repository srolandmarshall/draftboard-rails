require "test_helper"

class DraftPicksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @draft_pick = draft_picks(:one)
  end

  test "should get index" do
    get draft_picks_url
    assert_response :success
  end

  test "should get new" do
    get new_draft_pick_url
    assert_response :success
  end

  test "should create draft_pick" do
    assert_difference("DraftPick.count") do
      post draft_picks_url, params: { draft_pick: {  } }
    end

    assert_redirected_to draft_pick_url(DraftPick.last)
  end

  test "should show draft_pick" do
    get draft_pick_url(@draft_pick)
    assert_response :success
  end

  test "should get edit" do
    get edit_draft_pick_url(@draft_pick)
    assert_response :success
  end

  test "should update draft_pick" do
    patch draft_pick_url(@draft_pick), params: { draft_pick: {  } }
    assert_redirected_to draft_pick_url(@draft_pick)
  end

  test "should destroy draft_pick" do
    assert_difference("DraftPick.count", -1) do
      delete draft_pick_url(@draft_pick)
    end

    assert_redirected_to draft_picks_url
  end
end
