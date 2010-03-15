class AddThankedAtToContribution < ActiveRecord::Migration
  def self.up
    add_column :contributions, :thanked_at, :datetime
  end

  def self.down
    remove_column :contributions, :thanked_at
  end
end
