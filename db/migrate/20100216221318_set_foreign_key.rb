class SetForeignKey < ActiveRecord::Migration
  def self.up
    add_foreign_key :contributions, :business_id, :business
  end

  def self.down
    remove_foreign_key :contributions, :business
  end
end