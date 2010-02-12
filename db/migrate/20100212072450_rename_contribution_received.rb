class RenameContributionReceived < ActiveRecord::Migration
  def self.up
    remove_column :contributions, :_received
    add_column :contributions, :received_at, :date
  end

  def self.down
    remove_column :contributions, :received_at
    add_column :contributions, :_received, :boolean
  end
end
