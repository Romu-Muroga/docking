class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i[edit update destroy]

  def index
    @users = User.all
  end

  def edit; end

  def update
    params[:user][:admin] = params[:user][:admin] == '0'
    if @user.update(user_params)
      flash[:success] = t('flash.update', content: @user.name)
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    if @user.posts.destroy_all && @user.destroy
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
end
