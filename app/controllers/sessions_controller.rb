class SessionsController < ApplicationController
  skip_before_action :login_check
  def new; end

  def create
    # Unlike downcase !, the value is not updated.
    user = User.find_by(email: session_params[:email].downcase)
    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user.id), success: t('flash.login_succeeded')
    else
      flash.now[:danger] = t('flash.login_failed')
      render :new
    end
  end

  def destroy
    # session.delete(:user_id)
    reset_session
    redirect_to root_path, success: t('flash.logged_out')
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
