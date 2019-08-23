class Admin::TopsController < ApplicationController
  before_action :current_user_admin?
  def index; end

  private

  def current_user_admin?
    return if logged_in? && current_user.admin

    redirect_to root_path, danger: t('flash.Not_authorized')
  end
end
