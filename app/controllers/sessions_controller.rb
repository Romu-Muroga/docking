class SessionsController < ApplicationController
  def new; end

  def create
    # メールアドレスをすべて小文字で保存していているので、downcaseメソッドを使用して小文字に変更。
    # downcase!と違い値は更新しない。
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = t("flash.You_are_now_logged")
      redirect_to user_path(user.id)
    else
      flash[:danger] = t("flash.Login_failed")
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:success] = t("flash.logged_out")
    redirect_to root_path
  end
end
