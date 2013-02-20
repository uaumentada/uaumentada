require 'test_helper'

class MarketItemsControllerTest < ActionController::TestCase
  setup do
    @market_item = market_items(:one)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should show market_item" do
    get :show, :id => @market_item.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @market_item.to_param
    assert_response :success
  end

  test "should destroy market_item" do
    assert_difference('MarketItem.count', -1) do
      delete :destroy, :id => @market_item.to_param
    end

    assert_redirected_to market_items_path
  end
end
