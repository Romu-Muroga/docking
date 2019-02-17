class PostsController < ApplicationController
  before_action :login_check
  before_action :set_post, only: %i[show edit update destroy id_check]
  before_action :id_check, only: %i[show edit update destroy]

  def index# TODO: scope
    category_list
    @posts = if params[:category_id]
               Post.where(category_id: params[:category_id]).order(updated_at: :desc)
             else
               Post.all.order(updated_at: :desc)
             end
  end

  def search# TODO: scope
    category_list
    @posts = if params[:post][:eatery_address].present? && params[:post][:category_id].present? && params[:post][:ranking_point].present?
               Post.where("eatery_address LIKE ?", "%#{ params[:post][:eatery_address] }%").where(category_id: params[:post][:category_id]).where(ranking_point: params[:post][:ranking_point])
             elsif params[:post][:eatery_address].present?
               Post.where("eatery_address LIKE ?", "%#{ params[:post][:eatery_address] }%")
             elsif params[:post][:category_id].present?
               Post.where(category_id: params[:post][:category_id])
             elsif params[:post][:ranking_point].present?
               Post.where(ranking_point: params[:post][:ranking_point])
             end
    render :index
  end

  def new
    @post = Post.new
    @post.build_picture# has_oneでアソシエーションが定義されている場合に使える構文らしい
  end

  def create
    @post = Post.new(post_params)
    @post.build_picture(image: picture_params[:image])
    if @post.save!# TODO: !確認
      flash[:success] = "ランキングを登録しました！"
      redirect_to user_path(@post.user_id)
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    # @postと@post.pictureのどちらかがupdateに失敗したとき、どちらもupdateしない設定
    ActiveRecord::Base.transaction do
      @post.update!(post_params)
      @post.picture.update!(image: picture_params[:image])
    end
    flash[:success] = "ランキングを更新しました！"
    redirect_to user_path(@post.user_id)
  rescue
    # TODO: エラーメッセージが必要
    render :edit
  end

  def destroy
    @post.destroy
    flash[:success] = "ランキングを削除しました！"
    redirect_to user_path(@post.user_id)
  end

  private
  def post_params
    params.require(:post).permit(
      :category_id,
      :ranking_point,
      :eatery_name,
      :eatery_food,
      :eatery_address,
      :latitude,
      :longitude,
      :eatery_website,
      :remarks
    ).merge(
      user_id: current_user.id
    )
  end
  # params[:post][:image]は、picturesテーブルに保存するためpost_paramsと分離させる。
  def picture_params
    params.require(:post).permit(:image)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def login_check
    unless logged_in?
      flash[:danger] = "ログインして下さい！"
      redirect_to new_session_path
    end
  end

  def id_check
    unless @post.user_id == current_user.id
      flash[:danger] = "ユーザーが違います！"
      redirect_to new_session_path
    end
  end

  def category_list
    @categories = Category.all
  end
end
