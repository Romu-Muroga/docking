class PostsController < ApplicationController
  before_action :login_check
  before_action :set_post, only: %i[show edit update destroy id_check]
  before_action :id_check, only: %i[edit update destroy]

  def index# TODO: scope
    category_list
    @posts = if params[:category_id]
               Post.category_sort(params[:category_id])
             elsif params[:iine_sort]
               Post.iine_ranking
             elsif params[:overall_sort]
               Post.overall_ranking
             else
               Post.latest
             end
  end

  def search# TODO: scope + order(updated_at: :desc)
    category_list
    address = params[:post][:eatery_address]
    category = params[:post][:category_id]
    rank = params[:post][:ranking_point]
    name = params[:post][:eatery_name]
    if address.present? && category.present? && rank.present? && name.present?
      @posts = Post.all_search(address, category, rank, name)
      render :index
    elsif address.present?
      @posts = Post.address_search(address)
      render :index
    elsif category.present?
      @posts = Post.category_search(category)
      render :index
    elsif rank.present?
      @posts = Post.rank_search(rank)
      render :index
    elsif name.present?
      @posts = Post.name_search(name)
      render :index
    elsif address.blank? && category.blank? && rank.blank? && name.blank?
      flash[:warning] = "検索ワードを入力してください！"
      redirect_to posts_path
    end
  end

  def new
    @post = Post.new
    @post.build_picture# has_oneでアソシエーションが定義されている場合に使える構文らしい
  end

  def create
    @post = Post.new(post_params)
    @post.build_picture(image: picture_params[:image])
    if @post.save# TODO: !確認
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
      if @post.picture.blank? && picture_params[:image].blank?
        false
      elsif @post.picture.present? && picture_params[:image].blank?
        @post.picture.destroy
      elsif @post.picture.present?
        @post.picture.update!(image: picture_params[:image])
      elsif @post.picture.blank?
        @post.build_picture(image: picture_params[:image])
        @post.picture.save!
      end
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
