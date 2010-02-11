require 'test_helper'

class BusinessTypesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => BusinessType.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    BusinessType.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    BusinessType.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to business_type_url(assigns(:business_type))
  end
  
  def test_edit
    get :edit, :id => BusinessType.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    BusinessType.any_instance.stubs(:valid?).returns(false)
    put :update, :id => BusinessType.first
    assert_template 'edit'
  end
  
  def test_update_valid
    BusinessType.any_instance.stubs(:valid?).returns(true)
    put :update, :id => BusinessType.first
    assert_redirected_to business_type_url(assigns(:business_type))
  end
  
  def test_destroy
    business_type = BusinessType.first
    delete :destroy, :id => business_type
    assert_redirected_to business_types_url
    assert !BusinessType.exists?(business_type.id)
  end
end
