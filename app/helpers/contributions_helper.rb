module ContributionsHelper
  DELIVERY_METHODS_DESCRIPTIONS = { :mail =>    "I will mail it.", 
                                    :deliver => "I will bring it to the school.", 
                                    :pickup =>  "It will need to be picked up.", 
                                    :other =>   "Other (see details)" }.freeze

  # to change the order in which the methods are shown, define DELIVERY_METHODS_ORDER
  #
  DELIVERY_METHODS_ORDER = [:mail, :pickup, :deliver, :other].freeze
  #
  def delivery_methods_collection
    (DELIVERY_METHODS_ORDER || Contribution::DELIVERY_METHODS).collect do |method|
      [DELIVERY_METHODS_DESCRIPTIONS[method], method]
    end
  end
  
  def delivery_method_details(method)
    DELIVERY_METHODS_DESCRIPTIONS[method.to_sym]
  end
end
