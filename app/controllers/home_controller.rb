class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @users_count = User.all.size || 0
    @questions_count = Question.all.size || 0
    @quizzes_count = Quiz.all.size || 0
  end

  def show
  end
end
