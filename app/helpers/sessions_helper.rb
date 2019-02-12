module SessionsHelper
  # application_controller.rbに書くだけだと、コントローラでは使えるけどViewファイルでは使えない。
  # undefined method `logged_in?' for...エラーになってしまう。
  # Railsの初期設定では、全てのhelperが全てのViewから読み込める。
  def current_user
    @current_user || @current_user = User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end
end
