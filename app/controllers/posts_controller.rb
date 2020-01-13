class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = current_user.posts.build
  end

  def create
    #@post = current_user.posts.build(post_params)
    @post = Post.create(post_params.merge(user_id: current_user.id))

    if @post.save then
      redirect_to @post
    else
      redirect_to new_post_path(@post)
    end
  end

  def edit
  end

  def update
    if @post.update(post_params) then
      redirect_to @post
    else
      redirect_to edit_post_path(@post)
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:name, :content)
  end

  def find_post
    @post = Post.find(params[:id])
  end
end
