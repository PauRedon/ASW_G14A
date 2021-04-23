require "test_helper"

class VoteCommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vote_comment = vote_comments(:one)
  end

  test "should get index" do
    get vote_comments_url
    assert_response :success
  end

  test "should get new" do
    get new_vote_comment_url
    assert_response :success
  end

  test "should create vote_comment" do
    assert_difference('VoteComment.count') do
      post vote_comments_url, params: { vote_comment: {  } }
    end

    assert_redirected_to vote_comment_url(VoteComment.last)
  end

  test "should show vote_comment" do
    get vote_comment_url(@vote_comment)
    assert_response :success
  end

  test "should get edit" do
    get edit_vote_comment_url(@vote_comment)
    assert_response :success
  end

  test "should update vote_comment" do
    patch vote_comment_url(@vote_comment), params: { vote_comment: {  } }
    assert_redirected_to vote_comment_url(@vote_comment)
  end

  test "should destroy vote_comment" do
    assert_difference('VoteComment.count', -1) do
      delete vote_comment_url(@vote_comment)
    end

    assert_redirected_to vote_comments_url
  end
end
