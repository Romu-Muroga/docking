class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  helper_method :current_user, :logged_in?, :poster?
  before_action :login_check, :set_locale

  private

  def login_check
    return if logged_in?

    redirect_to login_path, danger: t('flash.please_login')
  end

  def set_locale
    I18n.locale = current_user&.locale || :ja
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def poster?(post)
    post.user_id == current_user.id
  end
end
