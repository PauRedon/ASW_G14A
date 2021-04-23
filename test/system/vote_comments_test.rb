require "application_system_test_case"

class VoteCommentsTest < ApplicationSystemTestCase
  setup do
    @vote_comment = vote_comments(:one)
  end

  test "visiting the index" do
    visit vote_comments_url
    assert_selector "h1", text: "Vote Comments"
  end

  test "creating a Vote comment" do
    visit vote_comments_url
    click_on "New Vote Comment"

    click_on "Create Vote comment"

    assert_text "Vote comment was successfully created"
    click_on "Back"
  end

  test "updating a Vote comment" do
    visit vote_comments_url
    click_on "Edit", match: :first

    click_on "Update Vote comment"

    assert_text "Vote comment was successfully updated"
    click_on "Back"
  end

  test "destroying a Vote comment" do
    visit vote_comments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Vote comment was successfully destroyed"
  end
end
