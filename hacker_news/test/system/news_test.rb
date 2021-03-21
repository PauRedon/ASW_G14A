require "application_system_test_case"

class NewsTest < ApplicationSystemTestCase
  setup do
    @news = news(:one)
  end

  test "visiting the index" do
    visit news_url
    assert_selector "h1", text: "News"
  end

  test "creating a News" do
    visit news_url
    click_on "New News"

    fill_in "Content", with: @news.content
    fill_in "Created at", with: @news.created_At
    fill_in "Likes", with: @news.likes
    fill_in "Tittle", with: @news.tittle
    fill_in "Url", with: @news.url
    fill_in "User", with: @news.user_id
    click_on "Create News"

    assert_text "News was successfully created"
    click_on "Back"
  end

  test "updating a News" do
    visit news_url
    click_on "Edit", match: :first

    fill_in "Content", with: @news.content
    fill_in "Created at", with: @news.created_At
    fill_in "Likes", with: @news.likes
    fill_in "Tittle", with: @news.tittle
    fill_in "Url", with: @news.url
    fill_in "User", with: @news.user_id
    click_on "Update News"

    assert_text "News was successfully updated"
    click_on "Back"
  end

  test "destroying a News" do
    visit news_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "News was successfully destroyed"
  end
end
