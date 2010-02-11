$stdout.sync = true

class PushBusinesses < ActiveRecord::Migration
  def self.up
    csv = File.open File.join(RAILS_ROOT, "db", "businesses.csv")
  
    # grab the field names
    fields = csv.readline.strip.split(';').collect(&:underscore).collect(&:to_sym)
    
    csv.each do |line|
      
      values = line.strip.split(';')
      
      params = Hash[ fields.zip(values) ]
      unless params[:name].blank? or params[:street].blank? or params[:city].blank? or params[:zip].blank? then
        params[:business_type_id] = BusinessType.find_or_create_by_name(params[:business_type]).id unless params[:business_type].blank?
        params.delete :business_type
        
        params.delete_if{ |key,value| value.blank? }
        
        new_business = Business.new params
        if new_business.save(false)
          print "#<Business id: #{new_business.id}, name: \"#{new_business.name}\"> "
        else
          puts "Error with businesses.csv:#{csv.lineno}"
        end
      end
    end
    print "\n"
  end

  def self.down
  end
end
