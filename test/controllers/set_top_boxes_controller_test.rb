require 'test_helper'

class SetTopBoxesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @set_top_box = set_top_boxes(:one)
  end

  test "should get index" do
    get set_top_boxes_url
    assert_response :success
  end

  test "should get new" do
    get new_set_top_box_url
    assert_response :success
  end

  test "should create set_top_box" do
    assert_difference('SetTopBox.count') do
      post set_top_boxes_url, params: { set_top_box: { name: @set_top_box.name } }
    end

    assert_redirected_to set_top_box_url(SetTopBox.last)
  end

  test "should show set_top_box" do
    get set_top_box_url(@set_top_box)
    assert_response :success
  end

  test "should get edit" do
    get edit_set_top_box_url(@set_top_box)
    assert_response :success
  end

  test "should update set_top_box" do
    patch set_top_box_url(@set_top_box), params: { set_top_box: { name: @set_top_box.name } }
    assert_redirected_to set_top_box_url(@set_top_box)
  end

  test "should destroy set_top_box" do
    assert_difference('SetTopBox.count', -1) do
      delete set_top_box_url(@set_top_box)
    end

    assert_redirected_to set_top_boxes_url
  end
end
