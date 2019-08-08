class Admin::TopsController < ApplicationController
  before_action :current_user_admin?
  def index; end

  private

  def current_user_admin?
    return if logged_in? && current_user.admin

    flash[:danger] = t('flash.Not_authorized')
    redirect_to root_path
  end
end
