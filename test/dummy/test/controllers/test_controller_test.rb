require 'test_helper'

class TestControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get test_index_url
    assert_response :success
  end

end
