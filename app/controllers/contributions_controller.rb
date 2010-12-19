class ContributionsController < ApplicationController

  def show
    @business = Business.find params[:business_id]
    @contribution = @business.contribution
  end
  
  def new
    @business = Business.find params[:business_id]
    @contribution = @business.build_contribution
  end
  
  def create
    @business = Business.find params[:business_id]
    @contribution = @business.create_contribution(params[:contribution])
    if @contribution.save
      flash[:notice] = "Successfully created contribution."
      redirect_to :action => :show
    else
      render :action => 'new'
    end
  end
  
  def edit
    @business = Business.find params[:business_id]
    @contribution = @business.contribution
  end
  
  def update
    @business = Business.find params[:business_id]
    @contribution = @business.contribution
    
    if @contribution.update_attributes(params[:contribution])
      flash[:notice] = "Successfully updated contribution."
      redirect_to :action => :show
    else
      render :action => 'edit'
    end
  end

end
