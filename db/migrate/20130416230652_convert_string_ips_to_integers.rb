class ConvertStringIpsToIntegers < ActiveRecord::Migration
   def up
      User.all.each do |user|
        if !user.last_sign_in_ip.blank?
          user.last_sign_in_ip = user.last_sign_in_ip
        end 
        if !user.current_sign_in_ip.blank?
          user.current_sign_in_ip = user.current_sign_in_ip
        end
        user.save
      end
      
      change_column :users, :current_sign_in_ip, :integer
      change_column :users, :last_sign_in_ip, :integer
    end

    def down
      change_column :users, :current_sign_in_ip, :string
      change_column :users, :last_sign_in_ip, :string
    end
end
