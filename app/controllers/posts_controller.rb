# frozen_string_literal: true

class PostsController < ApplicationController
  allow_unauthenticated_access only: %i[index show]
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
    @post = Current.user.posts.build
  end

  def edit
    @users = User.active
  end

  def create
    @post = Current.user.posts.build(post_params)

    if @post.save
      redirect_to @post, notice: t('controllers.notices.create', model: 'Post')
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: t('controllers.notices.update', model: 'Post')
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: t('controllers.notices.destroy', model: 'Post')
  end

  def upvote
    @post.upvote_by Current.user
    redirect_back(fallback_location: posts_path)
  end

  def downvote
    @post.downvote_from Current.user
    redirect_back(fallback_location: posts_path)
  end

  private

  def require_same_user
    return unless current_user != @post.user

    flash[:danger] = t('controllers.notices.no_edit', model: 'Post')
    redirect_to root_path
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
    params.expect(post: %i[title user_id content status excerpt slug author])
  end
end
