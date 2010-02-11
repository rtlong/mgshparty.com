class CreateContributions < ActiveRecord::Migration
  def self.up
    create_table :contributions do |t|
      t.references :business,  :null => false
      
      t.string  :nature,          :null => false
      t.decimal :value,           :null => false,   :precision => 8,  :scale => 2,  :default => 0.00
      
      t.text    :message
      
      t.integer :delivery_method, :null => false
      t.text    :delivery_details
      
      t.boolean :_received,       :null => false,   :default => 0
      
      t.timestamps
    end
  end
  
  def self.down
    drop_table :contributions
  end
end
