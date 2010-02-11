class Business < ActiveRecord::Base
  strip_attributes!

  attr_accessible :name, :business_type_id, :phone, :contact_name, :contact_phone, 
    :contact_email, :contact_department, :street, :street2, :city, :state, :zip, :responded_at, 
    :mailing_required, :mailing_printed
  
  has_one :contribution, :dependent => :destroy
  belongs_to :business_type
  
  validates_uniqueness_of :name, :scope => [:street, :city], :case_sensitive => false, :message => "This business already has an entry in the datebase for this location. Please go to the previous page to select the business entry."
  validates_presence_of :name, :business_type, :phone, :street, :city, :state, :zip
  validates_format_of :zip, :with => /\A#{Addressing::ZIP_PATTERN.source}\Z/, :message => "ZIP Code doesn't appear valid. Should be ##### or #####-####" 
  validates_format_of :phone, :with => Addressing::PHONE_PATTERN
  validates_format_of :contact_phone, :with => Addressing::PHONE_PATTERN, :allow_blank => true
  validates_format_of :contact_email, :with => Addressing::EMAIL_PATTERN, :allow_blank => true
  validates_format_of :city, :with => Addressing::CITY_PATTERN
  validates_format_of :street, :with => /\A#{Addressing::STREET_PATTERN.source}\s+#{Addressing::SECONDARY_UNIT_PATTERN.source}\Z/i
  
  default_scope :order => 'name'
  
  named_scope :search, lambda{ |*args|
    args.map do |arg|
      if arg.respond_to? :to_s
        arg.to_s.strip
      end
    end
    args.compact!
    unless args.empty? then
      keywords = args.shift.split(" ").push(args).flatten.compact
      
      keywords.map!{|keyword| "%#{keyword}%"}

      condition_str = []
      keywords.length.times{ condition_str << "name LIKE ?" }

      conditions = [condition_str.join(" AND "), keywords].flatten
      { :conditions => conditions }
    end
  }
end
