class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @users_count = Home.stats[:all_users]
    @questions_count = Home.stats[:all_questions]
    @quizzes_count = Home.stats[:all_completed_quizzes]

    return unless current_user

    redirect_to dashboard_path
  end

  def show
    # if user signed in show their stats
  end
end
