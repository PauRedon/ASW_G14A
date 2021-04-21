class User < ApplicationRecord
    def self.form_omniauth(response)
        User.find_or_create_by(uid: response[:uid], provider: response[:provider]) do |u|
            u.username = response[:provider][:name]
            u.password = response[:provider][:password]
        end 
    end
end
