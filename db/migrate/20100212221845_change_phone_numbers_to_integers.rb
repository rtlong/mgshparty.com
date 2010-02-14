class ChangePhoneNumbersToIntegers < ActiveRecord::Migration
  def self.up
    add_column :businesses, :phone_int, :bigint
    add_column :businesses, :phone_ext, :integer
    add_column :businesses, :contact_phone_int, :bigint
    add_column :businesses, :contact_phone_ext, :integer
    add_column :businesses, :zip_int, :integer
    Business.reset_column_information
    say_with_time "Updating businesses" do
      businesses = Business.all
      businesses.each do |b|
        if b.phone?
          phone, ext = b.phone.split(/x/i)
          b.update_attribute(:phone_int, phone.gsub(/[^0-9]/, "").to_i)
          b.update_attribute(:phone_ext, ext.gsub(/[^0-9]/, "").to_i) if ext
        end
        if b.contact_phone?
          phone, ext = b.contact_phone.split(/x/i)
          b.update_attribute(:contact_phone_int, phone.gsub(/[^0-9]/, "").to_i)
          b.update_attribute(:contact_phone_ext, ext.gsub(/[^0-9]/, "").to_i) if ext
        end
        if b.zip?
          b.update_attribute(:zip_int, b.zip.gsub(/[^0-9]/, "").to_i)
        end
        say "#{b.name} updated!", true
      end
    end
  
    remove_column :businesses, :phone
    remove_column :businesses, :contact_phone
    remove_column :businesses, :zip
    rename_column :businesses, :phone_int, :phone
    rename_column :businesses, :contact_phone_int, :contact_phone
    rename_column :businesses, :zip_int, :zip
   end
  def self.down
    add_column :businesses, :phone_string, :text
    add_column :businesses, :contact_phone_string, :text
    add_column :businesses, :zip_string, :text
    Business.reset_column_information
    say_with_time "Updating businesses" do
      businesses = Business.all
      businesses.each do |b|
        b.update_attribute(:phone_string, [b.phone, b.phone_ext].join(' x ')) if b.phone?
        b.update_attribute(:contact_phone_string, [b.contact_phone, b.contact_phone_ext].join(' x ')) if b.phone?
        b.update_attribute(:zip_string, b.zip.to_s) if b.zip?
        say "#{b.name} updated!", true
      end
    end
    remove_column :businesses, :phone
    remove_column :businesses, :contact_phone
    remove_column :businesses, :zip
    rename_column :businesses, :phone_string, :phone
    rename_column :businesses, :contact_phone_string, :contact_phone
    rename_column :businesses, :zip_string, :zip
    
  end
end
