class Admin::CategoriesController < ApplicationController
  # before_action :current_user_admin?
  before_action :set_category, only: %i[edit update destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = t('flash.create', content: @category.name)
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      flash[:success] = 'カテゴリーを更新しました！'
      redirect_to categories_path
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    flash[:success] = 'カテゴリーを削除しました！'
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end

  # 管理者画面実装予定
  # 管理者権限を持つユーザーでなかったらルートパスへ移動
  # def current_user_admin?
  #   unless logged_in? && current_user.admin?
  #     flash[:danger] = '権限がありません！'
  #     redirect_to root_path
  #   end
  # end
end
