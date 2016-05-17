class CommentsController < ApplicationController
  before_action :requires_login
  before_action :requires_author, only: [:destroy]

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id

    if @comment.save
      if @comment.parent_comment_id
        redirect_to comment_url(@comment.parent_comment_id)
      else
        redirect_to post_url(@comment.post_id)
      end
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to post_url(@comment.post_id)
    end
  end

  def destroy
    set_comment
    @comment.destroy
    redirect_to post_url(@comment.post_id)
  end

  def show
    set_comment
    render :show
  end

  def upvote
    vote(1)
  end

  def downvote
    vote(-1)
  end

  private
  def comment_params
    params.require(:comment).permit(:post_id, :content, :parent_comment_id)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def requires_author
    unless current_user == set_comment.author
      flash[:errors] = ["You are not the author!"]
      redirect_to post_url(@comment.post_id)
    end
  end

  def vote(direction)
    set_comment

    @uservote = Uservote.find_by(
      votable_id: @comment.id,
      votable_type: "Comment",
      user_id: current_user.id
    )

    if @uservote
      @uservote.update(value: direction)
    else
      @comment.uservotes.create!(
        user_id: current_user.id,
        value: direction
      )
    end

    redirect_to post_url(@comment.post_id)
  end
end
