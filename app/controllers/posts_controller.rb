class PostsController < ApplicationController
  before_action :set_post, only: %i[edit update destroy]
  autocomplete :post, :eatery_name, full: true, scopes: [:uniq_eatery_name], full_model: true
  autocomplete :post, :eatery_food, full: true, scopes: [:uniq_eatery_food], full_model: true
  autocomplete :post, :eatery_address, full: true, scopes: [:uniq_eatery_address], full_model: true

  def index
    category_list
    # defined for search_form
    @q = Post.ransack(params[:q])
    @posts = if params[:category_id]
               @q.result.category_sort(params[:category_id])
             else
               @q.result.latest
             end
    @iine_ranking_posts = Post.iine_ranking
    @overall_ranking_posts = Post.overall_ranking
  end

  def search
    category_list
    address = params[:q][:eatery_address_cont]
    name = params[:q][:eatery_name_cont]
    category = params[:q][:category_id_eq]
    rank = params[:q][:ranking_point_eq]
    if address.blank? && category.blank? && rank.blank? && name.blank?
      redirect_to posts_path, warning: t('flash.search_word_is_empty')
    else
      @q = Post.ransack(search_params)
      @posts = @q.result.latest
      @iine_ranking_posts = Post.iine_ranking
      @overall_ranking_posts = Post.overall_ranking
      render :index
    end
  end

  def new
    @post = Post.new
    # build_picture: has_oneが定義されている場合に使える構文
    @post.build_picture
  end

  def create
    begin
      params[:post][:ranking_point] = params[:post][:ranking_point].to_i# TODO
      @post = Post.new(post_params)
      @post.build_picture(image: picture_params[:image]) if picture_params[:image]
      if @post.save
        redirect_to (@post),
                    success: t('flash.create', content: @post.eatery_name)
      else
        render :new
      end
    rescue ArgumentError
      redirect_to new_post_path, danger: t('flash.invalid_value')
    end
  end

  def show
    @post = Post.find(params[:id])
    # Create instance to be used in input form
    @comment = Comment.new
    @comments = @post.comments
  end

  def edit; end

  def update
    ActiveRecord::Base.transaction do
      params[:post][:ranking_point] = params[:post][:ranking_point].to_i# TODO
      @post.update!(post_params)
      checkbox_value = params[:post][:picture_delete_check]
      form_submit_image = picture_params[:image]
      post_picture_update(@post, form_submit_image, checkbox_value)
    end
    redirect_to (@post),
                success: t('flash.update', content: @post.model_name.human)
    rescue ArgumentError
      redirect_to edit_post_path(@post), danger: t('flash.invalid_value')
    rescue => e
      puts e.message
      render :edit
  end

  def destroy
    @post.destroy
    redirect_to posts_path,
                success: t('flash.destroy', content: @post.model_name.human)
  end

  def hashtag
    @hashtag = Hashtag.find_by(hashname: params[:name])
    @hashtag_posts = @hashtag.posts
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

  # picturesテーブルに保存するparameterは、post_paramsと分離させる。
  def picture_params
    params.require(:post).permit(
      :image,
      :image_cache,
      :picture_delete_check
    )
  end

  def search_params
    params.require(:q).permit(
      :eatery_address_cont,
      :eatery_name_cont,
      :category_id_eq,
      :ranking_point_eq
    )
  end

  def set_post
    @post = Post.find(params[:id])
    redirect_to posts_path,
                danger: t('flash.access_denied', url: url_for(only_path: false)) unless poster?(@post)
  end

  def category_list
    @categories = Category.all
  end

  def post_picture_update(post, form_submit_image, checkbox_value)
    if post.picture.present? && checkbox_value == '1'
      post.picture.destroy!
    elsif post.picture.present? && form_submit_image.present?
      post.picture.update!(image: form_submit_image)
    elsif post.picture.blank? && form_submit_image.present?
      post.build_picture(image: form_submit_image)
      post.picture.save!
    end
  end
end
