require "test_helper"

class ContribuciosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contribucio = contribucios(:one)
  end

  test "should get index" do
    get contribucios_url
    assert_response :success
  end

  test "should get new" do
    get new_contribucio_url
    assert_response :success
  end

  test "should create contribucio" do
    assert_difference('Contribucio.count') do
      post contribucios_url, params: { contribucio: { content: @contribucio.content, title: @contribucio.title, url: @contribucio.url } }
    end

    assert_redirected_to contribucio_url(Contribucio.last)
  end

  test "should show contribucio" do
    get contribucio_url(@contribucio)
    assert_response :success
  end

  test "should get edit" do
    get edit_contribucio_url(@contribucio)
    assert_response :success
  end

  test "should update contribucio" do
    patch contribucio_url(@contribucio), params: { contribucio: { content: @contribucio.content, title: @contribucio.title, url: @contribucio.url } }
    assert_redirected_to contribucio_url(@contribucio)
  end

  test "should destroy contribucio" do
    assert_difference('Contribucio.count', -1) do
      delete contribucio_url(@contribucio)
    end

    assert_redirected_to contribucios_url
  end
end
