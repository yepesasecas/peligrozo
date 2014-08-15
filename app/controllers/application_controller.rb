class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  def user_logged_in?
    unless current_user
      flash[:error] = "You must be logged in to access this section"
      redirect_to landing_index_path
    end
  end
  def user_first_time?
  end
  helper_method :current_user, :user_logged_in?, :user_first_time?
end
