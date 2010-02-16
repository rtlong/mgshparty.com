class Admin::ContributionsController < Admin::AdminController
  before_filter :set_actions
  before_filter :get_business, :except => :index
  def index
    @contributions = Contribution.all :include => :business, :order => 'created_at DESC'
  end

  def show
    @actions.push ["Edit", {:action => 'edit'}]
    
    if @business.contribution
      @contribution = @business.contribution
    else
      redirect_to :action => 'new'
    end
  end

  def new
    @actions.push ["Cancel", {:action => 'show', :controller => :businesses, :id => @business.id}]
    
    @contribution = @business.build_contribution
  end
  
  def create
    if (params['contribution']['received'] != '1')
      params['contribution'].merge!('received_at(1i)' => '', 'received_at(2i)' => '', 'received_at(3i)' => '')
    end
    params['contribution'].delete 'received'
    
    @contribution = @business.build_contribution(params[:contribution])
    if @contribution.save
      @business.update_attributes :responded_at => Time.now
      flash[:notice] = "Successfully added contribution."
      redirect_to admin_business_contribution_path(@business)
    else
      flash[:error] = "Problem with saving."
      render :action => 'new'
    end
  end

  def edit
    @actions.push ["Cancel", {:action => 'show'}]
    
    @contribution = @business.contribution
  end
  
  def update
    @contribution = @business.contribution
    
    if (params['contribution']['received'] != '1')
      params['contribution'].merge!('received_at(1i)' => '', 'received_at(2i)' => '', 'received_at(3i)' => '')
    end
    params['contribution'].delete 'received'
    
    success = @contribution.update_attributes(params[:contribution])
    @business.responded_at ||= Time.now
    @business.save
    if success
      flash[:notice] = "Successfully updated contribution."
    else
      flash[:error] = "Problem saving contribution."
    end

    respond_to do |format|
      format.html do
        if success
          redirect_to admin_business_contribution_path(@business)
        else
          render :action => 'edit'
        end
      end
    end
  end
  
  def mark_received
    @contribution = @business.contribution
    @contribution.update_attribute :received_at, Date.today
    
    if request.xhr?
      respond_to do |format|
        format.html do
          render :text => "It was received today"
        end
        format.js
      end
    else
      redirect_to :action => :show
    end
  end

  protected
  
  def get_business
    @business = Business.find params[:business_id], :include => :contribution
  end
  
end
