require 'test_helper'

class RequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get root_url
    assert_response :success
  end

end
