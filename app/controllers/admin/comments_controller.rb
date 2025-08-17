class Admin::CommentsController < Admin::BaseController
  before_action :set_admin_comment, only: %i[show edit update destroy]

  # GET /admin/comments
  def index
    @admin_comments = Comment.all
  end

  # GET /admin/comments/1
  def show
  end

  # GET /admin/comments/new
  def new
    @admin_comment = Comment.new
  end

  # GET /admin/comments/1/edit
  def edit
  end

  # POST /admin/comments
  def create
    @admin_comment = Comment.new(admin_comment_params)

    if @admin_comment.save
      redirect_to @admin_comment, notice: 'Comment was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/comments/1
  def update
    if @admin_comment.update(admin_comment_params)
      redirect_to @admin_comment, notice: 'Comment was successfully updated.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/comments/1
  def destroy
    @admin_comment.destroy!
    redirect_to admin_comments_path, notice: 'Comment was successfully destroyed.', status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_comment
    @admin_comment = Comment.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def admin_comment_params
    params.expect(admin_comment: %i[content status post_id user_id])
  end
end
