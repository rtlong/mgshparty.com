class AddFlagsToBusiness < ActiveRecord::Migration
  def self.up
    add_column :businesses, :mailing_required, :boolean, :default => 1
    add_column :businesses, :mailing_printed, :boolean
  end

  def self.down
    remove_column :businesses, :mailing_required
    remove_column :businesses, :mailing_printed
  end
end
