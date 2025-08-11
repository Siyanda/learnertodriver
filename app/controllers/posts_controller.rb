# frozen_string_literal: true

class PostsController < ApplicationController
  allow_unauthenticated_access

  def index
    @posts = Post.published
  end

  def show
    @post = Post.friendly.find(params[:id])
  end
end
