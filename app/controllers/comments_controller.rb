class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)
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
    params.require(:comment).permit(:content, :post_id)
  end
end
