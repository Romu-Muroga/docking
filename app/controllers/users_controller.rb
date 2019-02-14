class UsersController < ApplicationController
  before_action :set_user, only: %i[show categoryitems edit update destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # セーブできたら同時にログイン
      session[:user_id] = @user.id
      flash[:success] = "アカウント登録＋ログインに成功しました！"
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @categories = Category.all
    # if params[:user_id] && params[:id]
    #   @user_posts = Post.where(user_id: @user).where(category_id: params[:id]).order(ranking_point: :desc)
    # else
        @user_posts = @user.posts
    # end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = "アカウント情報を更新しました！"
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "アカウントを削除しました！"
    redirect_to new_session_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
