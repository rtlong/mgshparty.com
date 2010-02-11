class CreateBusinesses < ActiveRecord::Migration
  def self.up
    create_table :businesses do |t|
      t.string     :name,            :null => false
      t.references :business_type
      t.string     :phone
      
      t.string     :contact_name
      t.string     :contact_department
      t.string     :contact_phone
      t.string     :contact_email
      
      t.string     :street,          :null => false
      t.string     :street2        
      t.string     :city,            :null => false
      t.string     :state,           :null => false
      t.string     :zip,             :null => false,     :limit => 10
      
      t.timestamps
      t.datetime :responded_at
    end
  end
  
  def self.down
    drop_table :businesses
  end
end
