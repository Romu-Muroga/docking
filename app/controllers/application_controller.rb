class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  helper_method :current_user, :logged_in?, :poster?
  before_action :login_check

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def login_check
    return if logged_in?

    redirect_to login_path, danger: t('flash.please_login')
  end

  def poster?(post)
    post.user_id == current_user.id
  end
end
