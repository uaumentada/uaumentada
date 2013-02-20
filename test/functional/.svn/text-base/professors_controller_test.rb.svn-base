require 'test_helper'

class ProfessorsControllerTest < ActionController::TestCase
  setup do
    @professor = professors(:one)
  end

  test "should show professor" do
    get :show, :id => @professor.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @professor.to_param
    assert_response :success
  end

  test "should destroy professor" do
    assert_difference('Professor.count', -1) do
      delete :destroy, :id => @professor.to_param
    end

    assert_redirected_to professors_path
  end
end
