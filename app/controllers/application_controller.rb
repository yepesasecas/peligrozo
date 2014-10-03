class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

    def current_user
      if session[:user_id]
        @current_user ||= User.find(session[:user_id]) 
      end
    end
    
    def user_logged_in?
      unless current_user
        flash[:error] = "You must be logged in to access this section"
        redirect_to landing_index_path
      end
    end

    def user_first_time?
      if current_user.at_friends?
        current_user.friends_done   
        #TODO
      elsif current_user.at_theaters?
        current_user.theaters_done
        redirect_to user_favorite_theaters_path current_user, steps: true
      elsif current_user.at_genres?
        current_user.genres_done
        redirect_to user_favorite_genres_path current_user, steps: true
      end
    end
    
    helper_method :current_user, :user_logged_in?, :user_first_time?
end
