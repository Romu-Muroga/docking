class Admin::TopsController < ApplicationController
  before_action :current_user_admin?
  def index; end

  private

  def current_user_admin?
    return if current_user.admin

    render file: Rails.root.join('public/404.html'),
           status: :not_found,
           layout: false,
           content_type: 'text/html'
  end
end
