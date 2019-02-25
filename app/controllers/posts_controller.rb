class PostsController < ApplicationController
  before_action :login_check
  before_action :set_post, only: %i[show edit update destroy id_check]
  before_action :id_check, only: %i[edit update destroy]

  def index
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

  def search
    category_list
    address = params[:post][:eatery_address]
    category = params[:post][:category_id]
    rank = params[:post][:ranking_point]
    name = params[:post][:eatery_name]
    if address.present? || category.present? || rank.present? || name.present?
      @posts = post_search(address, category, rank, name)
      render :index
    elsif address.blank? && category.blank? && rank.blank? && name.blank?
      flash[:warning] = t("flash.Search_word_is_empty")
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
    if @post.save
      flash[:success] = t("flash.create", content: @post.eatery_name)
      redirect_to user_path(@post.user_id)
    else
      render :new
    end
  end

  def show
    @comment = Comment.new# 入力フォームで使用するインスタンスを作成
    @comments = @post.comments# コメント一覧表示で使用するためのコメントデータを用意
  end

  def edit; end

  def update
    # @postと@post.pictureのどちらかがupdateに失敗したとき、どちらもupdateしない設定
    ActiveRecord::Base.transaction do
      @post.update!(post_params)
      checkbox_value = params[:post][:picture_delete_check].to_i
      form_submit_image = picture_params[:image]
      if @post.picture.blank? && form_submit_image.blank?
        false
      elsif @post.picture.present? && form_submit_image.blank? && checkbox_value == 1
        @post.picture.destroy
      elsif @post.picture.present? && form_submit_image.blank?
        false
      elsif @post.picture.present?
        @post.picture.update!(image: form_submit_image)
      elsif @post.picture.blank?
        @post.build_picture(image: form_submit_image)
        @post.picture.save!
      end
    end
    flash[:success] = t("flash.update", content: @post.model_name.human)
    redirect_to post_path(@post)
  rescue
    # TODO: エラーメッセージが必要？
    render :edit
  end

  def destroy
    @post.destroy
    flash[:success] = t("flash.destroy", content: @post.model_name.human)
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
      :remarks,
    ).merge(
      user_id: current_user.id
    )
  end
  # params[:post][:image]は、picturesテーブルに保存するためpost_paramsと分離させる。
  def picture_params
    params.require(:post).permit(:image, :image_cache, :picture_delete_check)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def login_check
    unless logged_in?
      flash[:danger] = t("flash.Please_login")
      redirect_to new_session_path
    end
  end

  def id_check
    unless @post.user_id == current_user.id
      flash[:danger] = t("flash.Unlike_users")
      redirect_to user_path(current_user.id)
    end
  end

  def category_list
    @categories = Category.all
  end

  def post_search(address, category, rank, name)
    if address.present? && category.present? && rank.present? && name.present?
      Post.all_search(address, category, rank, name)
    elsif address.present? && category.present?
      Post.address_search(address).category_search(category)
    elsif address.present? && rank.present?
      Post.address_search(address).rank_search(rank)
    elsif address.present? && name.present?
      Post.address_search(address).name_search(name)
    elsif category.present? && rank.present?
      Post.category_search(category).rank_search(rank)
    elsif category.present? && name.present?
      Post.category_search(category).name_search(name)
    elsif rank.present? && name.present?
      Post.rank_search(rank).name_search(name)
    elsif address.present?
      Post.address_search(address)
    elsif category.present?
      Post.category_search(category)
    elsif rank.present?
      Post.rank_search(rank)
    elsif name.present?
      Post.name_search(name)
    end
  end
end
