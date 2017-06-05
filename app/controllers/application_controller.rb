class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  add_flash_types :danger, :info, :warning, :success

  private
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  helper_method :current_user

  def authorize
    redirect_to login_path, alert: 'Not authorized' if current_user.nil?
  end
end
