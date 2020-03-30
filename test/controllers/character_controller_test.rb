require 'test_helper'

class CharacterControllerTest < ActionDispatch::IntegrationTest
  test "should get profile" do
    get character_profile_url
    assert_response :success
  end

end
