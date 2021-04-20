class SessionsController < ApplicationController
    def omniauth
       user = User.from_omniauth(request.env['omniauth.auth'])
       if user.valid?
           session[:user_id] = user.index
           redirect_to user_path(user_id)
       else
           redirect_to '/login'
       end
    end
end
