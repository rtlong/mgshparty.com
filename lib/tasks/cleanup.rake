namespace :db do
  namespace :cleanup do
    desc "Cleanup and normalize all the businesses' addressing fields. Will also find the proper zip code"
    task :businesses => :environment do
      for business in Business.all
        puts business.inspect
        business.street = business.street.gsub ".", ""
        if business.phone
          business.phone = business.phone.gsub /[^\dxP*#]/, ""
        end
        puts business.save ? "saved":"error"
      end
    end
  end  
end
