class UsersController < ApplicationController
  before_action :login_check, except: %i[new create]
  before_action :set_user, only: %i[show edit update destroy id_check]
  before_action :id_check, only: %i[edit update destroy]

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
      flash[:success] = "アカウント登録＋ログインに成功しました！"
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show#TODO: scope
    @categories = Category.all
    @user_posts = if params[:category_id]
                    Post.where(user_id: @user).where(category_id: params[:category_id]).order(ranking_point: :desc)
                  else
                    @user.posts.where(category_id: Category.first.id).order(ranking_point: :desc)
                  end
  end

  def edit; end

  def update#TODO: リファクタリング
    # @postと@post.pictureのどちらかが更新に失敗したとき、どちらも更新しない設定
    ActiveRecord::Base.transaction do
      @user.update!(user_params)
      if @user.picture.present? && !(picture_params[:image])
        @user.picture.destroy
      elsif @user.picture.present?
        @user.picture.update!(image: picture_params[:image])
      else
        @user.build_picture(image: picture_params[:image])
        @user.picture.save!
      end
    end
    flash[:success] = "アカウント情報を更新しました！"
    redirect_to user_path(@user.id)
  rescue
    render :edit
  end

  def destroy
    @user.destroy
    flash[:success] = "アカウントを削除しました！"
    redirect_to new_session_path
  end

  private
  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end
  # params[:user][:image]は、picturesテーブルに保存するためuser_paramsと分離させる。
  def picture_params
    params.require(:user).permit(:image)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def login_check
    unless logged_in?
      flash[:danger] = "ログインして下さい！"
      redirect_to new_session_path
    end
  end

  def id_check
    unless @user.id == current_user.id
      flash[:danger] = "ユーザーが違います！"
      redirect_to user_path(current_user)
    end
  end
end
