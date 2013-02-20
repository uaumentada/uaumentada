require 'test_helper'

class PoisControllerTest < ActionController::TestCase
  setup do
    @poi = pois(:one)
  end

  test "should show poi" do
    get :show, :id => @poi.to_param
    assert_response :success
  end

  test "should destroy poi" do
    assert_difference('Poi.count', -1) do
      delete :destroy, :id => @poi.to_param
    end

    assert_redirected_to pois_path
  end
end
