class BusinessType < ActiveRecord::Base
  attr_accessible :name
  
  has_many :businesses, :dependent => :nullify
  
  default_scope :order => 'name'
  
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_format_of :name, :with => /[A-Za-z]+(?:\s+[A-Za-z]+)*/
end
