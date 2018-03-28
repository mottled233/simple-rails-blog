module SessionsHelper
    def log_in(user)
        session[:user_id] = user.id
    end
    
    def current_user
        if(user_id = session[:user_id])
            @current_user ||= User.find(user_id)
        elsif (user_id = cookies.signed[:user_id])
            user = User.find(user_id)
            if user && user.remembered?(cookies[:remember_token])
                log_in user
                @current_user = user
            end
        end
    end
    
    def log_in?
        !current_user.nil?
    end
    
    def log_out
        return unless log_in?

        forget @current_user
        @current_user = session[:user_id] = nil
    end
    
    def remember(user)
        user.remember
        cookies.permanent.signed[:user_id] = user.id
        cookies[:remember_token] = user.remember_token
    end
    
    def forget(user)
       user.forget
       cookies.delete(:user_id)
       cookies.delete(:remember_token)
    end
end
