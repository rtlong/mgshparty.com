class Admin::ContributionsController < Admin::AdminController
  before_filter :set_actions
  
  def index
    @contributions = Contribution.all :include => :business, :order => 'received_at DESC, created_at DESC'
  end

  def show
    @actions.push ["Edit", {:action => 'edit'}]
    
    @contribution = Contribution.find params[:id]
  end

  def new
    @actions.push ["Cancel", {:action => 'show'}]
    
    @contribution = Contribution.new
  end

  def edit
    @actions.push ["Cancel", {:action => 'show'}]
    
    @contribution = Contribution.find params[:id], :include => :business
  end
  
  def create
    @contribution = Contribution.new(params[:contribution])
    if @contribution.save
      flash[:notice] = "Successfully added contribution."
      redirect_to [:admin, @contribution]
    else
      flash[:error] = "Problem with saving."
      render :action => 'new'
    end
  end
  
  def update
    @contribution = Contribution.find(params[:id])
    success = @contribution.update_attributes(params[:contribution])
    
    if success
      flash[:notice] = "Successfully updated contribution."
    else
      flash[:error] = "Problem saving contribution."
    end

    respond_to do |format|
      format.html do
        if success
          redirect_to [:admin, @contribution]
        else
          render :action => 'edit'
        end
      end
    end
  end

end
