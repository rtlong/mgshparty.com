class BusinessesController < ApplicationController
  def search
    index
  end
  
  def index
    respond_to do |format|
      format.html do
        @business = Business.new
      end
      format.js do
        if Business.search(params[:name]).count <= 10 then
          @businesses = Business.search(params[:name]).all
        end
      end
    end
    
    # This is required for the BusinessesController#search method to properly render the `index` 
    # template. I am using 'search' instead of just 'index' because of the Ajax POST request to that
    # url, which actually maps to the 'create' action.
    render :action => 'index'
  end
  
  def new
    @business = Business.new :city => "Maple Grove", :state => "MN", :zip => "55369"
    if params.has_key? :business
      @business.name = params[:business][:name]
    end
    
    render :action => 'confirm'
  end
  
  def create
    @business = Business.new(params[:business])
    @business.responded_at = Time.now
    if @business.save
      flash[:notice] = "Successfully added business info."
      redirect_to new_business_contribution_path(@business)
    else
      render :action => 'confirm'
    end
  end
  
  def edit
    @business = Business.find(params[:id])
    
    # If the business already has a contribution attached, send the user to the "Forgot Something?"
    # page, where he/she can update the business data and the contribution data at once
    if @business.contribution then
      redirect_to edit_business_contribution_path(@business)
    else  
      render :action => 'confirm'
    end
  end
  
  def update
    @business = Business.find(params[:id])
    @business.responded_at ||= Time.now
    @business.save
    if @business.update_attributes(params[:business])
      flash[:notice] = "Successfully updated business info."
      redirect_to new_business_contribution_path(@business)
    else
      render :action => 'confirm'
    end
  end
end
