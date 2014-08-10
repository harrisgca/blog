class PostsController < ApplicationController
  
  before_filter :authenticate_user!, only:[:new, :create, :edit, :update, :destroy]
  
  def index
    @posts = Post.revorder.page(params[:page]).per(10)
    @recent_posts = Post.recent
    
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = current_user.posts.new(post_params)
    
    if @post.save
      redirect_to @post
      flash[:notice] = "Post saved"
    else
      render 'new'
    end
  end
  
  def show
    @post = Post.friendly.find(params[:id])
    @recent_posts = Post.all(order:"created_at desc", limit: 5)

  end
  
  def edit
    @post = Post.friendly.find(params[:id])
  end
  
  def update
    @post = Post.friendly.find(params[:id])
    
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end
  
  def destroy
    @post = Post.friendly.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end
  
  def archive
    @archive_posts = Post.friendly.find(:all, order:"created_at desc").group_by{ |post| post.created_at.beginning_of_month}
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :text, :user_id, :slug)
  end
  
end
