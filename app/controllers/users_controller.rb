class UsersController < ApplicationController
  skip_before_action :login_check, only: %i[new confirm create]
  before_action :set_user, only: %i[
    show iine_post_list edit password_reset
    password_update update destroy destroy_confirm
  ]

  def new
    @user = User.new
    @user.build_picture
  end

  def confirm
    @user = User.new(user_params)
    @user.build_picture(image: picture_params[:image]) if picture_params[:image]
    @user.picture.image.cache! if @user.picture.present?
    return if @user.valid?

    render :new
  end

  def create
    @user = User.new(user_params)
    @user.build_picture.image.retrieve_from_cache!(params[:cache][:image]) if params[:cache]
    if params[:back]
      render :new
    elsif @user.save
      # Login at the same time if user can save
      session[:user_id] = @user.id
      redirect_to (@user),
                  success: t('flash.account_registration_and_login_completed', user: @user.name)
    else
      render :new
    end
  end

  def show
    @categories = Category.all
    @picture = Picture.find(Picture.random_post_picture_id) if
               Picture.random_post_picture_id.present?
    @user_posts = if params[:category_id]
                    Post.user_category_sort(@user, params[:category_id]).includes(:category, :picture)
                  else
                    @user.posts.default_sort.includes(:category, :picture)
                  end
  end

  def iine_post_list
    @iine_posts = @user.iine_posts
  end

  def edit; end

  def password_reset; end

  def password_update
    if params[:user][:old_password].blank? || params[:user][:password].blank?
      @user.password_blank_error(params[:user][:old_password], params[:user][:password])
      render :password_reset
    elsif !@user&.authenticate(old_password_params[:old_password])
      @user.errors.add(:old_password, 'が違います')
      render :password_reset
    elsif @user&.authenticate(old_password_params[:old_password]) && @user.update(user_params)
      redirect_to (@user), success: t('flash.password_updated')
    else
      render :password_reset
    end
  end

  def update
    ActiveRecord::Base.transaction do
      @user.update!(user_params)
      form_submit_image = picture_params[:image]
      checkbox_value = picture_params[:picture_delete_check].to_i
      user_picture_update(@user, form_submit_image, checkbox_value)
    end
    redirect_to (@user), success: t('flash.account_info_update')
    rescue => e
      puts e.message
      render :edit
  end

  def destroy_confirm; end

  def destroy
    checkbox_value = user_params[:destroy_check].to_i
    if checkbox_value == 1 && @user.destroy
      reset_session
    elsif checkbox_value == 1 && !@user.destroy
      redirect_to destroy_confirm_user_path(@user),
                  danger: t('flash.admin_last_user_cannot_be_deleted', user: @user.name)
    else
      redirect_to destroy_confirm_user_path(@user), warning: t('flash.please_check')
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :destroy_check
    )
  end

  # picturesテーブルに保存するparameterはuser_paramsと分離させる。
  def picture_params
    params.require(:user).permit(
      :image,
      :picture_delete_check
    )
  end

  def old_password_params
    params.require(:user).permit(:old_password)
  end

  def set_user
    @user = User.find(params[:id])
    redirect_to posts_path,
                danger: t('flash.access_denied', url: url_for(only_path: false)) unless @user == current_user
  end

  def user_picture_update(user, form_submit_image, checkbox_value)
    if user.picture.present? && checkbox_value == 1 && form_submit_image.present?
      user.picture.update!(image: form_submit_image)
    elsif user.picture.present? && checkbox_value == 1
      user.picture.destroy!
    elsif user.picture.present? && form_submit_image.present?
      user.picture.update!(image: form_submit_image)
    elsif user.picture.blank? && form_submit_image.present?
      user.build_picture(image: form_submit_image)
      user.picture.save!
    end
  end
end
