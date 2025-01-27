# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit update destroy]

  def show; end

  def edit; end

  def create
    @post = Post.friendly.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @comment.post, notice: t('controllers.notices.create', model: 'Comment')
    else
      render action: 'new'
    end
  end

  def update; end

  def destroy
    @comment.destroy
    redirect_to @comment.post, notice: t('controllers.notices.destroy', model: 'Comment'), status: :see_other
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.expect(comment: [:content, :post_id, :user_id])
  end
end
