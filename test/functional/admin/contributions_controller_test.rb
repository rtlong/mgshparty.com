require 'test_helper'

class Admin::ContributionsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Admin::Contributions.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Admin::Contributions.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Admin::Contributions.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to admin/contributions_url(assigns(:admin/contributions))
  end
  
  def test_edit
    get :edit, :id => Admin::Contributions.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Admin::Contributions.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Admin::Contributions.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Admin::Contributions.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Admin::Contributions.first
    assert_redirected_to admin/contributions_url(assigns(:admin/contributions))
  end
end
