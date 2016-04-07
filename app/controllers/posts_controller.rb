class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :requires_login
  before_action :requires_author, only: [:edit, :update, :destroy]

  # GET /posts
  # GET /posts.json

  # GET /posts/1
  # GET /posts/1.json
  def show
    render :show
  end

  # GET /posts/new
  def new
    @post = Post.new
    render :new
  end

  # GET /posts/1/edit
  def edit
    render :edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id

    if @post.save
      params[:post][:sub_ids].each do |sub_id|
        next if sub_id == ""
        postsub = PostSub.new(post_id: @post.id, sub_id: sub_id.to_i)
        postsub.save!
      end
      redirect_to sub_url(@post.subs.first)
    else
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    update_subs

    if @post.update_attributes(post_params)
      unless @post.subs.empty?
        redirect_to sub_url(@post.subs.first)
      else
        redirect_to subs_url
      end

    else
      flash[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def update_subs
    set_post
    old_subs = @post.sub_ids
    new_subs = params[:post][:sub_ids]
    delete_subs = old_subs - new_subs
    add_subs = new_subs - old_subs
    delete_subs.each do |sub_id|
      postsub = PostSub.find_by(post_id: @post.id, sub_id: sub_id)
      postsub.delete
    end

    add_subs.each do |sub_id|
      postsub = PostSub.new(post_id: @post.id, sub_id: sub_id)
      postsub.save
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    sub = @post.sub
    @post.destroy
    redirect_to sub_url(sub)
  end

  def upvote
    vote(1)
  end

  def downvote
    vote(-1)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:title, :author_id, :content, subs_ids: [])
  end

  def requires_author
    unless current_user == set_post.author
      flash[:errors] = ["You are not the author!"]
      redirect_to post_url(@post)
    end
  end

  def vote(direction)
    set_post

    @uservote = Uservote.find_by(
      votable_id: @post.id,
      votable_type: "Post",
      user_id: current_user.id
    )

    if @uservote
      @uservote.update(value: direction)
    else
      @post.uservotes.create!(
        user_id: current_user.id,
        value: direction
      )
    end

    redirect_to sub_url(@post.subs.first)
  end

end
