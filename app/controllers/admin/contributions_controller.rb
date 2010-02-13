class Admin::ContributionsController < Admin::AdminController
  before_filter :set_actions
  
  def index
    @contributions = Contribution.all :include => :business
  end

  def show
    @contribution = Contribution.find params[:id]
  end

  def new
    @contribution = Contribution.new
  end

  def edit
    @contribution = Contribution.find params[:id]
  end

end
