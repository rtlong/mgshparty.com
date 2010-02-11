class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_hash
      t.string :password_salt
      t.timestamps
    end
    
    User.create :username => "ryan", :password => "seven11", :password_confirmation => "seven11", :email => "ryan@rtlong.com"
  end
  
  def self.down
    drop_table :users
  end
end
