class Admin::UsersController < ApplicationController
  before_action :current_user_admin?
  before_action :set_user, only: %i[edit update destroy]

  def index
    @users = User.all
  end

  def edit; end

  def update
    params[:user][:admin] = params[:user][:admin] == '0'
    if @user.update(user_params)
      redirect_to admin_users_path,
                  success: t('flash.update', content: @user.name)
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t('flash.destroy', content: @user.name)
    else
      flash[:danger] = t('flash.admin_last_user_cannot_be_deleted', user: @user.name)
    end
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(:password, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def current_user_admin?
    return if current_user.admin

    redirect_to posts_path, danger: t('flash.access_denied', url: url_for(only_path: false))
  end
end
