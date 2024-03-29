class Business < ActiveRecord::Base
  strip_attributes!

  attr_accessible :name, :business_type_id, :phone, :contact_name, :contact_phone, 
    :contact_email, :contact_department, :street, :street2, :city, :state, :zip, :responded_at, 
    :mailing_required, :mailing_printed
  
  has_one :contribution, :dependent => :destroy
  belongs_to :business_type
  
  validates_uniqueness_of :name, :scope => [:street, :city], :case_sensitive => false, :message => "This business already has an entry in the datebase for this location. Please go to the previous page to select the business entry."
  validates_presence_of :name, :business_type, :street, :city, :state, :zip, :message => "Required"
  validates_format_of :zip, :with => /\A#{Addressing::ZIP_PATTERN.source}\Z/, :allow_blank => true, :message => "ZIP Code doesn't appear valid. Should be ##### or #####-####" 
  validates_format_of :phone, :with => Addressing::PHONE_PATTERN, :allow_blank => true, :message => "That phone number appears invalid."
  validates_format_of :contact_phone, :with => Addressing::PHONE_PATTERN, :allow_blank => true, :message => "That phone number appears invalid. Please enter a 10-digit US phone number."
  validates_format_of :contact_email, :with => Addressing::EMAIL_PATTERN, :allow_blank => true, :message => "That email does not appear valid. Please enter a 10-digit US phone number."
  validates_format_of :city, :with => Addressing::CITY_PATTERN, :allow_blank => true, :message => "Please enter a valid US city name"
  validates_format_of :street, :with => Addressing::STREET_PATTERN, :allow_blank => true, :message => "Please enter a valid US mailing address"
  validates_format_of :street2, :with => Addressing::SECONDARY_UNIT_PATTERN, :allow_blank => true, :message => "Please enter a valid US mailing address"
  
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
  
  named_scope :full_search, lambda{ |*args|
    args.map do |arg|
      if arg.respond_to? :to_s
        arg.to_s.strip
      end
    end
    args.compact!
    column_names = %w(name street)
    unless args.empty? then
      keywords = args.shift.split(" ").push(args).flatten.compact
      
      keywords.map!{|keyword| "%#{keyword}%"}

      conditions = keywords.collect{ |keyword|
        condition = column_names.collect { |column_name| "#{column_name} LIKE ?" }.join(" OR ")
        "(#{condition})"
      }.join(" AND ")
      
      { :conditions => [conditions, (keywords * column_names.length).sort].flatten }
    end
  }
  
  named_scope :responded, :conditions => 'responded_at IS NOT NULL'
  named_scope :not_responded, :conditions => 'responded_at IS NULL'
  
  def phone=(phone)
    # If two extensions are provided, only the first is stored
    phone, ext = phone.split(/x/i).collect{|str| str.gsub(/\D/, '').to_i}
    self[:phone] = phone
    self[:phone_ext] = ext || nil
  end
  def phone
    helpers.number_to_phone(self[:phone], :extension => self[:phone_ext])
  end
  def contact_phone=(phone)
    # If two extensions are provided, only the first is stored
    phone, ext = phone.split(/x/i).collect{|str| str.gsub(/\D/, '').to_i}
    self[:contact_phone] = phone
    self[:contact_phone_ext] = ext || nil
  end
  def contact_phone
    helpers.number_to_phone(self[:contact_phone], :extension => self[:contact_phone_ext])
  end
  def zip
    [self[:zip], self[:zip4]].compact.join "-"
  end
  
  def zip=(zip)
    zip, plus4 = Addressing::ZIP_PATTERN.match(zip.to_s)[1..2]
    self[:zip] = zip.to_i
    self[:zip4] = plus4 ? plus4.to_i : nil
  end
  
  def display_name
    self[:name].blank? ? "[unnamed business]" : self[:name]
  end

  def street
    self[:street].blank? ? "[invalid street address]" : self[:street]
  end
  
  def has_contact_info?
    contact_name? or contact_email? or contact_phone? or contact_department?
  end
  
  def helpers
    ActionController::Base.helpers
  end
end
