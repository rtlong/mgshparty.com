class Admin::ContributionsController < Admin::AdminController
  def index
    @contributions = Contribution.all :include => :business
  end

  def show
    @contribution = Contribution.find params[:id]
  end

  def new
  end

  def edit
  end

end
