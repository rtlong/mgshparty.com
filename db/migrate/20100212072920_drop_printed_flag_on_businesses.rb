class DropPrintedFlagOnBusinesses < ActiveRecord::Migration
  def self.up
    remove_column :businesses, :mailing_printed
  end

  def self.down
    add_column :businesses, :mailing_printed, :boolean
  end
end
