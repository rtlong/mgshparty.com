module ContributionsHelper
  DELIVERY_METHODS_DESCRIPTIONS = { :mail =>    "I will mail it to you", 
                                    :pickup =>  "it will need to be picked up", 
                                    :other =>   "Other (see details)" }.freeze

  # to change the order in which the methods are shown, define DELIVERY_METHODS_ORDER
  #
  DELIVERY_METHODS_ORDER = [:mail, :pickup, :other].freeze
  #
  def delivery_methods_collection
    (DELIVERY_METHODS_ORDER || Contribution::DELIVERY_METHODS).collect do |method|
      [DELIVERY_METHODS_DESCRIPTIONS[method], method]
    end
  end
  
  def delivery_method_details(method)
    DELIVERY_METHODS_DESCRIPTIONS[method.to_sym]
  end
  
  def delivery_method_display(contribution)
    case contribution.delivery_method.to_sym
    when :mail
    when :pickup
      [DELIVERY_METHODS_DESCRIPTIONS[contribution.delivery_method.to_sym], contribution.delivery_details].compact.join ", "
    when :other
      "it will get to you in the following method: #{contribution.delivery_details.strip}"
    end
  end
end
