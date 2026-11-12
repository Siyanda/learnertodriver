# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_post,                only: :create
  before_action :require_confirmed_email, only: :create
  before_action :set_comment,             only: :destroy

  rate_limit to: 5, within: 10.minutes, only: :create, by: -> { Current.user.id }, with: lambda {
    redirect_to @post, alert: t('.rate_limit_message')
  }

  def create
    @comment      = @post.comments.new(comment_params)
    @comment.user = Current.user

    if @comment.save
      redirect_to @post, notice: t('.awaiting_approval')
    else
      render :new, status: :unprocessable_content
    end
  end

  def destroy
    authorize! @comment

    @comment.destroy

    redirect_to @comment.post, notice: t('controllers.notices.destroy', model: 'Comment')
  end

  private

  def require_confirmed_email
    return if Current.user.confirmed?

    redirect_to @post, alert: t('comments.confirm_email_first')
  end

  def set_post
    @post = Post.friendly.find(params.expect(:post_id))
  end

  def set_comment
    @comment = Comment.find(params.expect(:id))
  end

  def comment_params
    params.expect(comment: %i[content])
  end
end
