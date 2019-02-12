class SessionsController < ApplicationController
  def new
  end

  def create
    # メールアドレスをすべて小文字で保存していているので、downcaseメソッドを使用して小文字に変更。
    # downcase!と違い値は更新しない。
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      # TODO: ログイン後の処理
    else
      # TODO: ログインに失敗したときのメッセージ
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    # TODO: ログアウト後の処理
  end
end
