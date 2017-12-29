class WelcomeController < ApplicationController

  def home
    if logged_in?
      @artist = Artist.find_or_create_by(params[:id])
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    else
      redirect_to login_url
    end
  end
end
