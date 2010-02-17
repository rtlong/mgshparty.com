class Admin::BusinessesController < Admin::AdminController
  before_filter :set_actions

  def index
    @actions.push ["Add", {:action => 'new'}]
    @actions.push ["Download", {:action => 'index', :format => 'csv'}]
    respond_to do |format|
      format.html do
        @responded_businesses = Business.responded.full_search(params[:q]).all(:include => :contribution, :order => 'responded_at DESC')
        @other_businesses = Business.not_responded.full_search(params[:q]).all
      end

      format.csv do
        fields = [:id, :name, :contact_name, :contact_department, :street, :street2, :city, :state, :zip]
        @businesses = Business.not_responded.all :conditions => :mailing_required, :order => :zip, :select => fields.join(',')
        
        render :text => [ 
            fields.join(';'), 
            @businesses.collect{ |b| fields.map{ |f| b.send(f) }.join(';') } ].flatten.join("\n")
      end
    end
  end

  def show
    @actions.push ["Create New", {:action => 'new'}]
    @actions.push ["Edit", {:action => 'edit'}]
    @actions.push ["Delete", {:action => 'destroy'}, {:confirm => "Are you sure? This business and its contribution, if it has one, will be destroyed.", :method=> 'delete'}]
    
    @business = Business.find params[:id], :include => :contribution
    @contribution = @business.contribution
  end

  def new
    @actions.push ["Cancel", {:action => 'index'}]
    
    @business = Business.new :city => "Maple Grove", :state => "MN", :zip => "55369"
  end
  
  def create
    @business = Business.new(params[:business])
    if @business.save
      flash[:notice] = "Successfully added business."
      redirect_to [:admin, @business]
    else
      flash[:error] = "Problem with saving."
      render :action => 'new'
    end
  end

  def edit
    @actions.push ["Cancel", {:action => 'show'}]
    
    @business = Business.find params[:id], :include => :contribution
  end
  
  def update
    @business = Business.find(params[:id])
    if request.xhr?
      @business.attributes = params[:business]
      # dont't validate on XmlHttpRequest
      success = @business.save(false)
    else
      success = @business.update_attributes(params[:business])
    end
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
  
  def destroy
    @business = Business.find(params[:id])
    @business.destroy
    
    respond_to do |format|
      format.html do
        redirect_to admin_businesses_path
      end
      format.js do
        render :update do |page|
          page.remove "business_#{@business.id}"  
          page.alert "Removed business by the name of '#{@business.display_name}'"
          page.call :set_totals
          
        end   
      end
    end
  end

end
