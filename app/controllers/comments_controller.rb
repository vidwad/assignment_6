class CommentsController < ApplicationController
  before_action :find_comment
  before_action :find_post
  before_action :authenticate_user!

  def create
    @comment = Comment.new comment_params
    @comment.post = @post
    @comment.user = current_user

    if @comment.save
      flash[:success] = "Comment added!"
      redirect_to @post
    else
      @comments = @post.comments.order(created_at: :desc)
      flash.now[:alert] = @comment.errors.full_messages.join(", ")
      render "posts/show"
    end
  end

  def destroy
    if can?(:crud, @comment)
    @comment.destroy
    flash[:success] = "Comment deleted"
    redirect_to @comment.post
    else
    flash[:alert] = "Not authorized to delete Comment!"
    redirect_to @comment.post
    end
  end

  private
  def find_comment
    @comment = Comment.find params[:id] if params[:id].present?
  end

  def find_post
    @post = Post.find params[:post_id] if params[:post_id].present?
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end