class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:create]
  before_action :set_comment, only: [:destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.commentable = find_commentable

    if @comment.save
      redirect_to @post, notice: "댓글이 등록되었습니다."
    else
      @comments = @post.comments.includes(:user, comments: :user)
      render "posts/show", status: :unprocessable_entity
    end
  end

  def destroy
    @post = comment_root_post(@comment)
    @comment.destroy!

    redirect_to @post, notice: "댓글이 삭제되었습니다."
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :commentable_type, :commentable_id)
  end

  def find_commentable
    return @post unless comment_params[:commentable_type].present? && comment_params[:commentable_id].present?

    permitted_type = %w[Post Comment]
    type = comment_params[:commentable_type]
    id = comment_params[:commentable_id]

    if permitted_type.include?(type)
      type.constantize.find(id)
    else
      @post
    end
  end

  def comment_root_post(comment)
    if comment.commentable.is_a?(Post)
      comment.commentable
    else
      comment_root_post(comment.commentable)
    end
  end
end
