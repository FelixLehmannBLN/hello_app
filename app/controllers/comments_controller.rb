class CommentsController < ApplicationController
 before_action :set_comment, only: [:edit, :update, :destroy]
 before_action :set_post
 before_action :authenticate_user!, except: [:index, :show]
 before_action :correct_user, only: [:edit, :update, :destroy]

def new
  @comment = @post.comments.build
end

def create
  @comment = @post.comments.build(comment_params)
  @comment.user_id = current_user.id
  if @comment.save
    redirect_to @post
  else
    render 'new'
  end
end

def edit
end

def update
  if @comment.update(comment_params)
    redirect_to @post
  else
    render 'edit'
  end
end

def destroy
  @comment.destroy
  redirect_to @post
end

private

  def comment_params
      params.require(:comment).permit(:content)
  end

  def set_comment
    @comment = comment.find(params[:id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    redirect_to root_url if @comment.nil?
  end

end
