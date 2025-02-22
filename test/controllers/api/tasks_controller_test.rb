require "test_helper"

class Api::TasksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_tasks_index_url
    assert_response :success
  end
end
