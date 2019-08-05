class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def destroy
    user = User.find(params[:id])
    return unless user.posts.destroy_all && user.destroy

    flash[:success] = t('flash.destroy', content: user.name)
    redirect_to admin_users_path
  end
end
