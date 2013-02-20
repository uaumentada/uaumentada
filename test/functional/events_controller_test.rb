require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete :destroy, :id => @event.to_param
    end

    assert_redirected_to events_path
  end
end
