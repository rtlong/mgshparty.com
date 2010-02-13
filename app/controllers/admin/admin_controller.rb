class Admin::AdminController < ApplicationController
  before_filter :login_required
  before_filter :set_actions
  
  
  def set_actions
    @actions = [
      ["View All", {:action => 'index'}]]
  end

end
