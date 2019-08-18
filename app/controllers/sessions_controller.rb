class SessionsController < ApplicationController
  def new; end

  def create
    # Unlike downcase !, the value is not updated.
    user = User.find_by(email: params[:session][:email].downcase)
    if user && password_check(user, params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = t('flash.You_are_now_logged')
      redirect_to user_path(user.id)
    else
      flash[:danger] = t('flash.Login_failed')
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:success] = t('flash.logged_out')
    redirect_to root_path
  end

  private

  def password_check(user, password)
    user.authenticate(password)
  end
end
