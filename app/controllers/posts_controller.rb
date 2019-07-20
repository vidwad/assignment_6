class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_post
  before_action :authorize!, only: [:edit, :update, :destroy]

  def index
    @posts = Post.order(created_at: :desc)
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params
    @post.user = current_user
    if @post.save
      flash[:success] = "Post created!"
      redirect_to @post
    else
      flash.now[:alert] = @post.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
    
  end

  def update
    if @post.update post_params
      flash[:success] = "Post updated!"
      redirect_to @post
    else
      flash.now[:alert] = @post.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Post deleted"
    redirect_to posts_path
  end

  private
  
  def find_post
    @post = Post.find(params[:id]) if params[:id].present?
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def authorize!
    redirect_to root_path, alert: 'Not Authorized' unless can?(:crud, @post)
  end

end
