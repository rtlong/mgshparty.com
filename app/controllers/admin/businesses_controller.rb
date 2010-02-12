class Admin::BusinessesController < Admin::AdminController
  def index
    respond_to do |format|
      format.html do
        @responded_businesses = Business.responded.full_search(params[:q]).all(:include => :contribution, :order => 'responded_at DESC')
        @other_businesses = Business.not_responded.full_search(params[:q]).all
      end

      format.csv do
        @businesses = Business.not_responded.all :conditions => :mailing_required, :order => :name
        fields = [:id, :name, :contact_name, :contact_department, :street, :street2, :city, :state, :zip]
        render :text => [ 
            fields.join(','), 
            @businesses.collect{ |b| fields.map{ |f| b.send(f) }.join(',') } ].flatten.join("\n")
      end
    end
  end

  def show
    @business = Business.find params[:id], :include => :contribution
    @contribution = @business.contribution
  end

  def new
  end

  def edit
    @business = Business.find params[:id], :include => :contribution
  end
  
  def update
    @business = Business.find(params[:id])
    @business.attributes = params[:business]
    success = @business.save(false)
    if success
      flash[:notice] = "Successfully updated business."
    else
      flash[:error] = "Problem saving business."
    end

    respond_to do |format|
      format.html do
        if success
          redirect_to admin_business_path(@business)
        else
          render :action => 'edit'
        end
      end
      format.js
    end
  end

end
