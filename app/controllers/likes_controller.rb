class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    return if @post.iine?(current_user)

    @post.iine(current_user)
    # Re-fetch records from database
    @post.reload
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

  def destroy
    @post = Like.find(params[:id]).post
    return unless @post.iine?(current_user)

    @post.uniine(current_user)
    @post.reload
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end
end
