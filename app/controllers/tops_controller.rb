class TopsController < ApplicationController
  skip_before_action :login_check
  def index; end
end
