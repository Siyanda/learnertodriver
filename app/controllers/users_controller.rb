class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show
    @user_posts = @user.posts.includes(:rich_text_content)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit( :first_name, :last_name, :username, :bio, :birthday)
    end
end