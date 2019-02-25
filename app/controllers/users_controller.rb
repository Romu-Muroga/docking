class UsersController < ApplicationController
  before_action :login_check, except: %i[new create]
  before_action :set_user, only: %i[show edit update destroy destroy_confirm id_check]
  before_action :id_check, only: %i[edit update destroy destroy_confirm]

  def new
    @user = User.new
    @user.build_picture#has_oneでアソシエーションが定義されている場合に使える構文らしい
  end

  def create
    @user = User.new(user_params)
    @user.build_picture(image: picture_params[:image]) if picture_params[:image]#アイコン画像は未登録可
    if @user.save
      # セーブできたら同時にログイン
      session[:user_id] = @user.id
      flash[:success] = t("flash.account_registration_and_login_completed", user: @user.name)
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @categories = Category.all
    @user_posts = if params[:category_id]
                    Post.user_category_sort(@user, params[:category_id])
                  else
                    @user.posts.default_sort
                  end
  end

  def edit; end

  def update
    # @postと@post.pictureのどちらかが更新に失敗したとき、どちらも更新しない設定
    ActiveRecord::Base.transaction do
      @user.update!(user_params)
      checkbox_value = params[:user][:picture_delete_check].to_i
      form_submit_image = picture_params[:image]
      if @user.picture.blank? && form_submit_image.blank?
        false
      elsif @user.picture.present? && form_submit_image.blank? && checkbox_value == 1
        @user.picture.destroy
      elsif @user.picture.present? && form_submit_image.blank?
        false
      elsif @user.picture.present?
        @user.picture.update!(image: form_submit_image)
      else
        @user.build_picture(image: form_submit_image)
        @user.picture.save!
      end
    end
    flash[:success] = t("flash.account_information_update")
    redirect_to user_path(@user)
  rescue
    render :edit
  end

  def destroy_confirm; end

  def destroy
    # render nothing: :true
    checkbox_value = params[:user][:destroy_check].to_i
    if checkbox_value == 1
      @user.destroy
      flash[:success] = t("flash.Delete_account_Thank_you_for_using", user: @user.name)
      redirect_to root_path
    else
      flash[:warning] = t("flash.Please_check")
      redirect_to destroy_confirm_user_path(@user)# 退会処理画面へリダイレクト
    end
    # binding.pry
  end

  private
  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :destroy_check
    )
  end
  # params[:user][:image]は、picturesテーブルに保存するためuser_paramsと分離させる。
  def picture_params
    params.require(:user).permit(:image, :picture_delete_check)# TODO: アイコン画像を削除するときに送られてくるparameter
  end

  def set_user
    @user = User.find(params[:id])
  end

  def login_check
    unless logged_in?
      flash[:danger] = t("flash.Please_login")
      redirect_to new_session_path
    end
  end

  def id_check
    unless @user.id == current_user.id
      flash[:danger] = t("flash.Unlike_users")
      redirect_to user_path(current_user)
    end
  end
  # メソッド化しようとしたけど、返り値が全てtrueになってしまうため中止
  # def true_or_false
  #   if params[:user][:destroy_check] = "1"
  #     return true
  #   elsif params[:user][:destroy_check] = "2"
  #     return false
  #   end
  # end
end
