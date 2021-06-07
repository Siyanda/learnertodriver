class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_post_options
  before_action :set_post, only: %i[show edit update destroy upvote downvote]
  before_action :require_same_user, only: %i[edit update destroy]

  def index
    @posts = Post.published
  end

  def show
    @posts = Post.published
  end

  def new
    @post = current_user.posts.build
  end

  def edit
    @users = User.active
  end

  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_path, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
    @post.upvote_by current_user
    redirect_back(fallback_location: posts_path)
  end

  def downvote
    @post.downvote_from current_user
    redirect_back(fallback_location: posts_path)
  end

  private

  def require_same_user
    if current_user != @post.author
      flash[:danger] = 'Not authorized to edit this post'
      redirect_to root_path
    end
  end

  def set_post_options
    @users = User.active
    @pages = Page.all
    @page_list = @pages.map { |page| [page.title, page.id] }
    @editor_list = @users.map { |user| [user.name, user.id] }
  end

  def set_post
    @post = Post.friendly.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :user_id, :content, :status, :slug, :author)
  end
end
