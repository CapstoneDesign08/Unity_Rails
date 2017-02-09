require 'test_helper'

class Api::UnitysControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_unitys_index_url
    assert_response :success
  end

end
