class Contribution < ActiveRecord::Base
  strip_attributes!
  
  # DO NOT change the order of this!! See ContributionsHelper#delivery_methods_collection to change the display order
  DELIVERY_METHODS = [ :mail, :pickup, :other ].freeze
  
  attr_accessible :nature, :value, :message, :delivery_method, :delivery_details, :received_at, :business_attributes
  #attr_accessor :received

  belongs_to :business  
  accepts_nested_attributes_for :business

  validates_presence_of :nature, :value, :delivery_method, :business_id, :message => "Required"
  validates_presence_of :delivery_details, :message => "Please explain the details of how we will get the contribution", :if => Proc.new { |c| c.delivery_method == :other }
  
  named_scope :received, :condition => 'received_at IS NOT NULL'
  
  def received
    !!self[:received_at]
  end
#  def received_at=(date)
#    self[:received_at] = @received ? date : nil
#  end
                  
  def delivery_method
    if self[:delivery_method] then
      DELIVERY_METHODS[self[:delivery_method]]
    else
      nil
    end
  end
    
  def delivery_method=(method)
    method = DELIVERY_METHODS.index method.to_sym
    self[:delivery_method] = method if method
  end
  
  def value
    DollarValue.new(self[:value])
  end
  
  def value=(value)
    self[:value] = DollarValue.new(value).to_f
  end

  def received?
    received_at?
  end
  
end
