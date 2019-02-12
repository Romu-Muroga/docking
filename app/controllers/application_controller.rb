class ApplicationController < ActionController::Base
  # 全コントローラでSessionsHelperモジュールを使用するための記述
  include SessionsHelper
end
