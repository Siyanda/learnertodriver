class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit update destroy]

  def create
    @post = Post.friendly.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post, notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: 'new' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_back(fallback_location: posts_path, notice: 'Comment successfully deleted') }
      format.json { head :no_content }
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id)
  end
end
