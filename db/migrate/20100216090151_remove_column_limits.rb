class RemoveColumnLimits < ActiveRecord::Migration
  def self.up 
    change_column :businesses, :phone, :bigint, {:limit => nil}
    change_column :businesses, :contact_phone, :bigint, {:limit => nil}
    change_column :businesses, :zip, :bigint, {:limit => nil}
  end

  def self.down
  end
end
