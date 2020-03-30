require 'test_helper'

class EpisodeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get episode_index_url
    assert_response :success
  end

end
