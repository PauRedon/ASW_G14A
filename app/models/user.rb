class User < ApplicationRecord
    def self.form_omniauth(response)
        User.find_or_create_by(index response[:index]) do |u|
            u.username = response[:info][:name]
            u.password = response[:info][:password]
        end 
    end
end
