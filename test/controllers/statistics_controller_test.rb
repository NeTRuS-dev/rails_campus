require 'test_helper'

class StatisticsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get statistics_index_url
    assert_response :success
  end

  test "should get average" do
    get statistics_average_url
    assert_response :success
  end

end
