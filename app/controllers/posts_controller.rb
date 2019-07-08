class PostsController < ApplicationController
   
    before_action :find_post, only: [:show, :edit, :update, :destroy]
  
    def new
      @post = Post.new
    end
  
    def create
      @post = Post.new post_params
      
      if @post.save
        flash[:notice] = "Post created successfully"
        # if post is saved successfully redirect to post show page
        redirect_to post_path(@post)
      else
        # render views/posts/new.html.erb
        render :new
      end
    end
  
    def show
      # For the 'form_with' helper
      @comment = Comment.new
      # For the list of comments
      @comments = @post.comments.order(created_at: :desc)
    end
  
    def index
      @posts = Post.all
    end
  
    def edit
    end
  
    def update
      # attempt to edit the existing question with new values
      if @post.update post_params
        redirect_to post_path(@post)
      else
        render :edit
      end
    end
  
    def destroy
      flash[:notice] = "Post destoryed!"
      @post.destroy
      redirect_to posts_path
    end
  
    private
  
    def post_params
      
      params.require(:post).permit(:title, :body)
    end
  
    def find_post
      # get the current value inside of the db
      @post = Post.find params[:id]
    end
  
  end