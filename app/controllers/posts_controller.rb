class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  private
    def set_post
      @post = Post.friendly.find(params[:id])
    end

    def post_params
      params.require(:post).permit( :title, :user_id)
    end
end