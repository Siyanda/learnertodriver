class Admin::PostsController < Admin::BaseController
  before_action :set_admin_post, only: %i[show edit update destroy]

  # GET /admin/posts
  def index
    @admin_posts = Post.all
  end

  # GET /admin/posts/1
  def show
  end

  # GET /admin/posts/new
  def new
    @admin_post = Post.new
  end

  # GET /admin/posts/1/edit
  def edit
  end

  # POST /admin/posts
  def create
    @admin_post = Post.new(admin_post_params)

    if @admin_post.save
      redirect_to @admin_post, notice: 'Post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/posts/1
  def update
    if @admin_post.update(admin_post_params)
      redirect_to @admin_post, notice: 'Post was successfully updated.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/posts/1
  def destroy
    @admin_post.destroy!
    redirect_to admin_posts_path, notice: 'Post was successfully destroyed.', status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_post
    @admin_post = Post.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def admin_post_params
    params.expect(admin_post: %i[title content slug published_at status excerpt user_id])
  end
end
