class Admin::TopsController < ApplicationController
  before_action :current_user_admin?
  def index; end

  private

  def current_user_admin?
    return if current_user.admin

    redirect_to posts_path, danger: t('flash.access_denied', url: url_for(only_path: false))
  end
end
