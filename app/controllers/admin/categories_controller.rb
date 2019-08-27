class Admin::CategoriesController < ApplicationController
  before_action :current_user_admin?
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
      redirect_to admin_categories_path,
                  success: t('flash.create', content: @category.name)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path,
                  success: t('flash.update', content: @category.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to admin_categories_path,
                success: t('flash.destroy', content: @category.name)
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def current_user_admin?
    return if current_user.admin

    redirect_to posts_path, danger: t('flash.Not_authorized')
  end
end
