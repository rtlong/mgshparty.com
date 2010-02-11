class Admin::BusinessesController < Admin::AdminController
  def index
    respond_to do |format|
      format.html do
        @businesses = Business.all(:include => :contribution, :order => 'responded_at DESC').group_by{|b| b.contribution.nil?}.collect{|has_contribution, businesses| businesses.group_by(&:name)}
      end
      format.csv do
        @businesses = Business.all :conditions => "mailing_required IS NOT NULL"
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
    if @business.update_attributes(params[:business])
      flash[:notice] = "Successfully updated business."
      redirect_to admin_business_path(@business)
    else
      render :action => 'edit'
    end
  end
  
  def update_multiple
    params[:business].each_pair do |business_id, business_params|
      business = Business.find(business_id)
      business.update_attributes business_params
    end
  
  
    redirect_to admin_businesses_path
  end

end
