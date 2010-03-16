ActionController::Routing::Routes.draw do |map|
  map.namespace :admin do |admin|
    admin.resources :contributions, :only => :index, :collection => [:unthanked]
    admin.resources :businesses do |business|
      business.resource :contribution, :member => {:mark_received => [:post, :get], :mark_thanked => [:post, :get]}
    end
    admin.resources :business_types
    
    admin.resources :sessions
    admin.resources :users
    admin.signup '1198c38a11dbdf935af35342d959fb24ca07cecc', :controller => 'users', :action => 'new'
    admin.logout 'logout', :controller => 'sessions', :action => 'destroy'
    admin.login 'login', :controller => 'sessions', :action => 'new'
    admin.root :controller => 'businesses', :action => 'index'
  end

  map.resources :businesses, :except => :show, :collection => {:search => [:get,:post]}, :new => {:new => :post} do |business|
    business.resource :contribution, :except => :index
  end
  
  map.letter 'letter', :controller => 'pages', :action => 'letter'
  map.contribute 'contribute', :action => 'index', :controller => 'businesses'
  # For now, map the root to the contribute page
  map.root :action => 'index', :controller => 'businesses'
end
