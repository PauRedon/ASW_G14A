require "application_system_test_case"

class ContribuciosTest < ApplicationSystemTestCase
  setup do
    @contribucio = contribucios(:one)
  end

  test "visiting the index" do
    visit contribucios_url
    assert_selector "h1", text: "Contribucios"
  end

  test "creating a Contribucio" do
    visit contribucios_url
    click_on "New Contribucio"

    fill_in "Content", with: @contribucio.content
    fill_in "Likes", with: @contribucio.likes
    fill_in "Tittle", with: @contribucio.tittle
    fill_in "Url", with: @contribucio.url
    fill_in "User", with: @contribucio.user_id
    click_on "Create Contribucio"

    assert_text "Contribucio was successfully created"
    click_on "Back"
  end

  test "updating a Contribucio" do
    visit contribucios_url
    click_on "Edit", match: :first

    fill_in "Content", with: @contribucio.content
    fill_in "Likes", with: @contribucio.likes
    fill_in "Tittle", with: @contribucio.tittle
    fill_in "Url", with: @contribucio.url
    fill_in "User", with: @contribucio.user_id
    click_on "Update Contribucio"

    assert_text "Contribucio was successfully updated"
    click_on "Back"
  end

  test "destroying a Contribucio" do
    visit contribucios_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Contribucio was successfully destroyed"
  end
end
