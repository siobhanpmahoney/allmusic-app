class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :logged_in?

  private

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end
