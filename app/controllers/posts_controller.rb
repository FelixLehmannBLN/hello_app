class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]


def index
  @posts = Post.where("group_id IN (?)", current_user.group_ids)
end

def show
end

def new
  @post = current_user.posts.build
end

def create
  @post = current_user.posts.build(post_params)
  if @post.save
    redirect_to @post
  else
    render 'new'
  end
end

def edit
end

def update
  @post.update_attributes(post_params)
  if @post.save
    redirect_to @post
  else
    render 'edit'
  end
end

def destroy
  @post.destroy
  redirect_to root_url
end

private

  def post_params
      params.require(:post).permit(:title, :content, :group_id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end
end
