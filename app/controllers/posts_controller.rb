class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "ランキングを登録しました！"
      redirect_to#TODO: リダイレクト先
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:success] = "ランキングを更新しました！"
      redirect_to#TODO: リダイレクト先
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "ランキングを削除しました！"
    redirect_to#TODO: リダイレクト先
  end

  private
  def post_params
    params.require(:post).permit(:ranking_point,
                                 :eatery_name,
                                 :eatery_food,
                                 :eatery_address,
                                 :latitude,
                                 :longitude,
                                 :eatery_website,
                                 :remarks
                                )
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
