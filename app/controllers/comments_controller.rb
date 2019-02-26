class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    return unless @comment.save

    respond_to do |format|
      format.js { render :index }
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    return unless @comment.destroy

    respond_to do |format|
      format.js { render :index }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id)
  end
end
