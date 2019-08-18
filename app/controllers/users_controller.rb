class UsersController < ApplicationController
  before_action :login_check, except: %i[new create]
  before_action :set_user, only: %i[
    show iine_post_list edit password_reset
    password_update update destroy destroy_confirm
  ]

  def new
    @user = User.new
    @user.build_picture
  end

  def create
    @user = User.new(user_params)
    @user.build_picture(image: picture_params[:image]) if picture_params[:image]
    if @user.save
      # Login at the same time if user can save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id),
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
                    Post.user_category_sort(@user, params[:category_id])
                  else
                    @user.posts.default_sort
                  end
  end

  def iine_post_list
    @iine_posts = @user.iine_posts
  end

  def edit; end

  def password_reset; end

  def password_update
    if params[:user][:password].blank?
      @user.add_errors
      render :password_reset
    elsif @user.update(user_params)
      redirect_to user_path(@user), success: t('flash.password_updated')
    else
      render :password_reset
    end
  end

  def update
    ActiveRecord::Base.transaction do
      @user.update!(user_params)
      checkbox_value = params[:user][:picture_delete_check].to_i
      form_submit_image = picture_params[:image]
      if @user.picture.blank? && form_submit_image.blank?
        false
      elsif @user.picture.present? && form_submit_image.blank? && checkbox_value == 1
        @user.picture.destroy!
      elsif @user.picture.present? && form_submit_image.blank?
        false
      elsif @user.picture.present?
        @user.picture.update!(image: form_submit_image)
      else
        @user.build_picture(image: form_submit_image)
        @user.picture.save!
      end
    end
    redirect_to user_path(@user), success: t('flash.account_information_update')
  rescue ActiveRecord::RecordInvalid
    render :edit
  end

  def destroy_confirm; end

  def destroy
    checkbox_value = params[:user][:destroy_check].to_i
    # user >> (o)posts >> (x)picture
    # ポリモーフィックでhas_oneの関連を持つpictureは、dependent: :destroyで、
    # user.pictureは消せるけど、孫にあたるpost.pictureまでは消せない
    if checkbox_value == 1 && (@user.posts.destroy_all && @user.destroy)
      redirect_to root_path,
                  success: t('flash.Delete_account_Thank_you_for_using', user: @user.name)
    else
      redirect_to destroy_confirm_user_path(@user), warning: t('flash.Please_check')
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
      :image_cache,
      :picture_delete_check
    )
  end

  def set_user
    # TODO
    if params[:id].to_i == current_user.id
      @user = current_user
    else
      redirect_to user_path(current_user), danger: t('flash.Unlike_users')
    end
  end

  def login_check
    return if logged_in?

    redirect_to new_session_path, danger: t('flash.Please_login')
  end
end
