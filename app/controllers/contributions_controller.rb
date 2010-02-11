class ContributionsController < ApplicationController
  def show
    @contribution = Contribution.find_by_business_id params[:business_id]
  end
  
  def new
    business = Business.find params[:business_id]
    @contribution = business.build_contribution
  end
  
  def create
    business = Business.find params[:business_id]
    @contribution = business.create_contribution(params[:contribution])
    if @contribution.save
      flash[:notice] = "Successfully created contribution."
      redirect_to :action => :show
    else
      render :action => 'new'
    end
  end
  
  def edit
    @contribution = Contribution.find_by_business_id params[:business_id]
  end
  
  def update
    @contribution = Contribution.find_by_business_id params[:business_id]
    
    if @contribution.update_attributes(params[:contribution])
      flash[:notice] = "Successfully updated contribution."
      redirect_to :action => :show
    else
      render :action => 'edit'
    end
  end

end
