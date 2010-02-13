class Contribution < ActiveRecord::Base
  strip_attributes!
  
  # DO NOT change the order of this!! See ContributionsHelper#delivery_methods_collection to change the display order
  DELIVERY_METHODS = [ :mail, :deliver, :pickup, :other ].freeze
  
  attr_accessible :business_id, :nature, :value, :message, :delivery_method, :delivery_details, :_received, :business_attributes

  belongs_to :business  
  accepts_nested_attributes_for :business

  validates_presence_of :nature, :value, :delivery_method
  
  named_scope :received, :condition => 'received_at IS NOT NULL'
                  
  def delivery_method
    if self[:delivery_method] then
      DELIVERY_METHODS[self[:delivery_method]]
    else
      nil
    end
  end
    
  def delivery_method=(method)
    self[:delivery_method] = DELIVERY_METHODS.index method.to_sym
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
