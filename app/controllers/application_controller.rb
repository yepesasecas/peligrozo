class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_action :set_user_country

  private

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def current_user_is_an_admin?
      [1, 2, 3, 5, 11, 16, 17].include?(current_user.id)
    end

    def current_country
      code = cookies[:country_code].presence || "PE"
      @current_country = Country.find_by(code: code) || Country.find_by(code: "PE")
    end

    def set_user_country
      cookies[:country_code] = params[:country].upcase if params[:country]
    end
    
    def user_logged_in?
      unless current_user
        flash[:error] = "You must be logged in to access this section"
        redirect_to landing_index_path
      end
    end

    def admin_logged_in?
      unless current_user_is_an_admin?
        redirect_to root_path, notice: "Lo siento mucho, no eres administrador"
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
    
    helper_method :current_user, :user_logged_in?, :user_first_time?,
      :current_user_is_an_admin?, :admin_logged_in?, :current_country            
end
