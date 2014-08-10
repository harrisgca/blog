class PagesController < ApplicationController
  
  before_filter :authenticate_user!, only:[:new, :create, :edit, :update, :destroy, :index]
  
  def index
    @pages = Page.order("created_at desc").page(params[:page]).per(10)
  end
  
  def new
    @page = Page.new
  end
  
  def create
    @page = current_user.pages.new(post_params)
    
    if @page.save
      redirect_to @page
    else
      render 'new'
    end
  end
  
  def show
    @page = Page.friendly.find(params[:id])
  end
  
  def edit
    @page = Page.friendly.find(params[:id])
  end
  
  def update
    @page = Page.friendly.find(params[:id])
    
    if @page.update(post_params)
      redirect_to @page
    else
      render 'edit'
    end
  end
  
  def destroy
    @page = Page.friendly.find(params[:id])
    @page.destroy
    redirect_to pages_path
  end
  
  
  private
  
  def post_params
    params.require(:page).permit(:title, :text, :user_id, :slug)
  end
  
end
