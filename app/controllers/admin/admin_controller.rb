class Admin::AdminController < ApplicationController
  before_filter :login_required, :except => [:summary]
  before_filter :set_actions
  
  
  def set_actions
    @actions = [
      ["View All", {:action => 'index'}]]
  end

end
