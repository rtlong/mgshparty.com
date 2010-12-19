require 'csv'

class Admin::ContributionsController < Admin::AdminController
  before_filter :set_actions
  before_filter :get_business, :except => [:index, :unthanked, :summary]
  
  def index
    @actions.push ["Printable Summary", {:action => 'summary'}]
    @actions.push ["Unthanked", {:action => 'unthanked'}]
    
    @contributions = Contribution.all :include => :business, :order => 'created_at DESC'
  end

  def unthanked
    @contributions = Contribution.unthanked.all :include => :business, :order => 'created_at DESC'
  end
  
  def summary
    @contributions = Contribution.all( :include => :business ).sort{|a,b| a.business.name <=> b.business.name}
    
    @headers = ['Business', 'Contribution Nature', 'Contribution Value']
    
    @total_value = DollarValue.new( @contributions.sum{|c| c.value.to_f } ).to_s
    @total_liquid_value = DollarValue.new( @contributions.sum{|c| c.liquid_value? ? c.value.to_f : 0.0 } ).to_s
    
    flash[:notice] = "For best results, print this using Firefox"
    
    respond_to do |wants|
      wants.html do
        # render template
      end
      wants.csv do
        csv_data_matrix = []
        # Headers
        csv_data_matrix << (@headers.push 'Liquid Value?')
        # Data
        @contributions.each do |c|
          csv_data_matrix << [c.business.name, c.nature, c.value.to_f.to_s]
        end
        
        # allot for Ruby1.8 on DH servers
        if CSV.const_defined? :Reader    # use old CSV code here…
          csv_string = StringIO.new
          CSV::Writer.generate(csv_string, ',') do |csv|
            csv_data_matrix.each do |c|
              csv << c
            end
          end
          csv_string.rewind
          csv_string = csv_string.read
        else # use FasterCSV style code, but with CSV class, here…
          csv_string = CSV.generate{ |csv|
            csv_data_matrix.each do |c|
              csv << c
            end
          }
        end
        
        # send it to the browser
        send_data csv_string, :type => 'text/csv; charset=utf8; header=present', :disposition => "attachment", :filename => "ANP.contributions_summary.csv"
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
      #@business.update_attributes :responded_at => Time.now
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
    #@business.responded_at ||= Time.now
    #@business.save
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
