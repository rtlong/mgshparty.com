class CreateBusinessTypes < ActiveRecord::Migration
  def self.up
    create_table :business_types do |t|
      t.string :name
      t.timestamps
    end
    
  end
  
  def self.down
    drop_table :business_types
  end
end
