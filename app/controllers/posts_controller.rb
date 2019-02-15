class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @categories = Category.all
    @posts = if params[:category_id]
               Post.where(category_id: params[:category_id]).order(updated_at: :desc)#TODO: scope
             else
               Post.all
             end
  end

  def new
    @post = Post.new
    @post.images.build
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "ランキングを登録しました！"
      redirect_to user_path(@post.user_id)
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:success] = "ランキングを更新しました！"
      redirect_to user_path(@post.user_id)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "ランキングを削除しました！"
    redirect_to user_path(@post.user_id)
  end

  private
  def post_params
    params.require(:post).permit(:category_id,
                                 :ranking_point,
                                 :eatery_name,
                                 :eatery_food,
                                 :eatery_address,
                                 :latitude,
                                 :longitude,
                                 :eatery_website,
                                 :remarks,
                                 :user_id,
                                 images_attributes: [:id, :image, :_destroy]
                                )
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
