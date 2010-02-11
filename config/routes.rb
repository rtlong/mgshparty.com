ActionController::Routing::Routes.draw do |map|
  map.namespace :admin do |admin|
    #admin.update_multiple_businesses "businesses", :controller => "businesses", :action => :update_multiple, :conditions => {:method => :put}
    admin.resources :businesses, :collection => {:update => :put}
    admin.resources :contributions  
    admin.resources :business_types
    admin.resources :sessions
    admin.resources :users
    admin.signup '1198c38a11dbdf935af35342d959fb24ca07cecc', :controller => 'users', :action => 'new'
    admin.logout 'logout', :controller => 'sessions', :action => 'destroy'
    admin.login 'login', :controller => 'sessions', :action => 'new'
    admin.root :controller => 'businesses', :action => 'index'
  end

  map.resources :businesses, :only => [:index, :update, :edit, :new, :create], :collection => {:search => [:get,:post]}, :new => {:new => :post} do |business|
    business.resource :contribution, :only => [:show, :new, :create, :edit, :update]
  end
    
  map.contribute 'contribute', :action => 'index', :controller => 'businesses'
  
  # For now, map the root to the contribute page
  map.root :action => 'index', :controller => 'businesses'

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  #  map.connect ':controller/:action/:id'
  #  map.connect ':controller/:action/:id.:format'
end
