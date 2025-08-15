# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_post,    only: :create
  before_action :set_comment, only: :destroy

  def create
    @comment      = @post.comments.new(comment_params)
    @comment.user = Current.user

    if @comment.save
      redirect_to @post, notice: t('controllers.notices.create', model: 'Comment')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! @comment
    @comment.destroy

    redirect_to @comment.post, notice: t('controllers.notices.destroy', model: 'Comment')
  end

  private

  def set_post
    @post = Post.friendly.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.expect(comment: %i[content post_id user_id])
  end
end
