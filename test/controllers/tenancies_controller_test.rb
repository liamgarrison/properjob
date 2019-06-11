require 'test_helper'

class TenanciesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tenancies_index_url
    assert_response :success
  end

  test "should get show" do
    get tenancies_show_url
    assert_response :success
  end

  test "should get new" do
    get tenancies_new_url
    assert_response :success
  end

  test "should get create" do
    get tenancies_create_url
    assert_response :success
  end

end
