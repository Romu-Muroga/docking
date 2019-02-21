class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    unless @post.iine?(current_user)# @postを現在のユーザーがいいねしていなかったら
      @post.iine(current_user)
      @post.reload# データベースからレコードを再取得する
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end

  def destroy
    @post = Like.find(params[:id]).post
    if @post.iine?(current_user)# @postを現在のユーザーがいいねしていたら
      @post.uniine(current_user)
      @post.reload# データベースからレコードを再取得する
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end
end
