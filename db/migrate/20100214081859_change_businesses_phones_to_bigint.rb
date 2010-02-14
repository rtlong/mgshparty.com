class ChangeBusinessesPhonesToBigint < ActiveRecord::Migration
  def self.up
    change_column :businesses, :phone, :bigint
    change_column :businesses, :contact_phone, :bigint
  end

  def self.down
  end
end
