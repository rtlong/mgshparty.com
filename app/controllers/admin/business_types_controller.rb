class Admin::BusinessTypesController < Admin::AdminController
  def index
    @business_types = BusinessType.all :include => :businesses
    @new_business_type = BusinessType.new
    
    render 'index'
  end

  def show
    @business_type = BusinessType.find params[:id], :include => :businesses
  end

  def create
    @business_type = BusinessType.new(params[:business_type])
    if @business_type.save
      flash[:notice] = "Successfully created business."
    else
      flash[:error] = "Problem with that type name."
    end
    redirect_to :action => :index
  end

  def update
    @business_type = BusinessType.find params[:id]
  end
  
  def destroy
    @business_type = BusinessType.find params[:id]
    @business_type.destroy
    redirect_to :action => :index
  end

end
