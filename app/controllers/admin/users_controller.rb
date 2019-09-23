class Admin::UsersController < ApplicationController
  before_action :current_user_admin?
  before_action :set_user, only: %i[edit update destroy]
  PER = 10

  def index
    @users = User.page(params[:page]).per(PER)
  end

  def edit; end

  def update
    set_admin_value(params[:user][:admin].to_i)
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

    render file: Rails.root.join('public/404.html'),
           status: :not_found,
           layout: false,
           content_type: 'text/html'
  end

  def set_admin_value(value_sent)
    if value_sent == 0
      params[:user][:admin] = true
    elsif value_sent == 1
      params[:user][:admin] = false
    else
      render :edit
    end
  end
end
