require 'test_helper'

class NavsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:navs)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_nav
    assert_difference('Nav.count') do
      post :create, :nav => { }
    end

    assert_redirected_to nav_path(assigns(:nav))
  end

  def test_should_show_nav
    get :show, :id => navs(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => navs(:one).id
    assert_response :success
  end

  def test_should_update_nav
    put :update, :id => navs(:one).id, :nav => { }
    assert_redirected_to nav_path(assigns(:nav))
  end

  def test_should_destroy_nav
    assert_difference('Nav.count', -1) do
      delete :destroy, :id => navs(:one).id
    end

    assert_redirected_to navs_path
  end
end
