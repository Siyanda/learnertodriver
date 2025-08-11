# frozen_string_literal: true

class QuizzesController < ApplicationController
  allow_unauthenticated_access

  def index
    @quizzes = Quiz.published
  end
end
