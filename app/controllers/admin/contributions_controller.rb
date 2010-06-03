require 'csv'

class Admin::ContributionsController < Admin::AdminController
  before_filter :set_actions
  before_filter :get_business, :except => [:index, :unthanked, :summary]
  
  def index
    @contributions = Contribution.all :include => :business, :order => 'created_at DESC'
  end

  def unthanked
    @contributions = Contribution.unthanked :include => :business, :order => 'created_at DESC'
  end
  
  def summary
    @contributions = Contribution.all( :include => :business ).sort{|a,b| a.business.name <=> b.business.name}
    
    respond_to do |wants|
      wants.csv do
        csv_string = CSV.generate{ |csv|
          # header row
          csv << %w[name contribution_nature contribution_value liquid_value?]

          # data rows
          @contributions.each do |contribution|
            csv << [contribution.business.name, contribution.nature, contribution.value.to_f, (/cash|check/i === contribution.nature).to_s]
          end
        }

        # send it to the browsah
        send_data csv_string, :type => 'text/csv; charset=utf-8; header=present', :disposition => "attachment; filename=ANP.contributions_summary.csv"
      end
    end
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
  
  def mark_thanked
    @contribution = @business.contribution
    @contribution.update_attribute :thanked_at, Time.now
    
    if request.xhr?
      respond_to do |format|
        format.html do
          render :text => "Y"
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
