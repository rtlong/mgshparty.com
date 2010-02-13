class AddBusinessesZipPlus4 < ActiveRecord::Migration
  def self.up
    add_column :businesses, :zip4, :integer
    Business.reset_column_information
    say_with_time "Updating businesses" do
      businesses = Business.all
      businesses.each do |b|
        b.update_attribute(:zip, b.zip)
        say "#{b.name} updated!", true
      end
    end
  end

  def self.down
    remove_column :businesses, :zip4
  end
end
