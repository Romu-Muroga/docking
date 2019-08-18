class SessionsController < ApplicationController
  def new; end

  def create
    # Unlike downcase !, the value is not updated.
    user = User.find_by(email: params[:session][:email].downcase)
    if user && password_check(user, params[:session][:password])
      session[:user_id] = user.id
      redirect_to user_path(user.id), success: t('flash.You_are_now_logged')
    else
      flash[:danger] = t('flash.Login_failed')
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, success: t('flash.logged_out')
  end

  private

  def password_check(user, password)
    user.authenticate(password)
  end
end
