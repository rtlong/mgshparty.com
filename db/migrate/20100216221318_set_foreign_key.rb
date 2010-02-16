class SetForeignKey < ActiveRecord::Migration
  def self.up
    add_foreign_key :contributions, :business_id, :businesses
  end

  def self.down
    remove_foreign_key :contributions, :businesses
  end
end
