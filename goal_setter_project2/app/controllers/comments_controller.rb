class CommentsController < ApplicationController
  before_action :requires_author, only: [:destroy]

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      if comment_params[:commentable_type] == "User"
        redirect_to user_url(@comment.commentable_id)
      elsif comment_params[:commentable_type] == "Goal"
        redirect_to goal_url(@comment.commentable_id)
      end
    else
      flash.now[:errors] = @comment.errors.full_messages
      if comment_params[:commentable_type] == "User"
        render user_url(@comment.commentable_id)
      elsif comment_params[:commentable_type] == "Goal"
        render goal_url(@comment.commentable_id)
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    if @comment.commentable_type == "User"
      redirect_to user_url(@comment.commentable_id)
    elsif @comment.commentable_type == "Goal"
      redirect_to goal_url(@comment.commentable_id)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:commentable_id, :commentable_type, :body)
  end

  def requires_author
    @comment = Comment.find(params[:id])
    unless @comment.author == current_user ||
      @comment.commentable == current_user ||
      (@comment.commentable_type == "Goal" && @comment.commentable.user == current_user)

      flash[:errors] = ['You are not the author of this comment']
      if @comment.commentable_type == "User"
        redirect_to user_url(@comment.commentable_id)
      elsif @comment.commentable_type == "Goal"
        redirect_to goal_url(@comment.commentable_id)
      end
    end
  end
end
