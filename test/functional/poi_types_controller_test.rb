require 'test_helper'

class PoiTypesControllerTest < ActionController::TestCase
  setup do
    @poi_type = poi_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:poi_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create poi_type" do
    assert_difference('PoiType.count') do
      post :create, :poi_type => @poi_type.attributes
    end

    assert_redirected_to poi_type_path(assigns(:poi_type))
  end

  test "should show poi_type" do
    get :show, :id => @poi_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @poi_type.to_param
    assert_response :success
  end

  test "should update poi_type" do
    put :update, :id => @poi_type.to_param, :poi_type => @poi_type.attributes
    assert_redirected_to poi_type_path(assigns(:poi_type))
  end

  test "should destroy poi_type" do
    assert_difference('PoiType.count', -1) do
      delete :destroy, :id => @poi_type.to_param
    end

    assert_redirected_to poi_types_path
  end
end
