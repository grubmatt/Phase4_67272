require 'test_helper'

class StoreFlavorsControllerTest < ActionController::TestCase
  setup do
    @store_flavor = store_flavors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:store_flavors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create store_flavor" do
    assert_difference('StoreFlavor.count') do
      post :create, store_flavor: { flavor_id: @store_flavor.flavor_id, store_id: @store_flavor.store_id }
    end

    assert_redirected_to store_flavor_path(assigns(:store_flavor))
  end

  test "should show store_flavor" do
    get :show, id: @store_flavor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @store_flavor
    assert_response :success
  end

  test "should update store_flavor" do
    patch :update, id: @store_flavor, store_flavor: { flavor_id: @store_flavor.flavor_id, store_id: @store_flavor.store_id }
    assert_redirected_to store_flavor_path(assigns(:store_flavor))
  end

  test "should destroy store_flavor" do
    assert_difference('StoreFlavor.count', -1) do
      delete :destroy, id: @store_flavor
    end

    assert_redirected_to store_flavors_path
  end
end
