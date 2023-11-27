require "test_helper"

class UserPropertiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_property = user_properties(:one)
  end

  test "should get index" do
    get user_properties_url, as: :json
    assert_response :success
  end

  test "should create user_property" do
    assert_difference("UserProperty.count") do
      post user_properties_url, params: { user_property: { property_id: @user_property.property_id, user_id: @user_property.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show user_property" do
    get user_property_url(@user_property), as: :json
    assert_response :success
  end

  test "should update user_property" do
    patch user_property_url(@user_property), params: { user_property: { property_id: @user_property.property_id, user_id: @user_property.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy user_property" do
    assert_difference("UserProperty.count", -1) do
      delete user_property_url(@user_property), as: :json
    end

    assert_response :no_content
  end
end
