# frozen_string_literal: true

require 'test_helper'

class DashboardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user     = create(:user, first_name: 'Thandi')
    @quiz     = create(:quiz, title: 'Road signs')
    @question = create(:question)
    @answer   = create(:answer, question: @question)

    @quiz.questions << @question
    create(:correct_answer, question: @question, answer: @answer)
  end

  test 'guests are sent to sign in' do
    get dashboard_path

    assert_redirected_to new_session_path
  end

  test 'shows an empty state before any tests are taken' do
    sign_in_as @user

    get dashboard_path

    assert_response :success
    assert_select 'h1', text: 'Hi Thandi'
    assert_select '.resume-card', count: 0
    assert_select 'p', text: I18n.t('dashboards.show.no_results')
    assert_select "#progress_quiz_#{@quiz.id} a[href='#{new_quiz_evaluation_path(@quiz)}']", text: 'Start'
  end

  test 'shows results, progress and the test in progress' do
    completed   = create(:evaluation, :completed, user: @user, quiz: @quiz)
    in_progress = create(:evaluation, :in_progress, user: @user, quiz: @quiz)
    create(:choice, evaluation: completed, question: @question, answer: @answer)
    sign_in_as @user

    get dashboard_path

    assert_select ".resume-card a[href='#{edit_quiz_evaluation_path(@quiz, in_progress)}']", text: 'Resume'
    assert_select "#evaluation_#{completed.id} meter[value='100']"
    assert_select "#progress_quiz_#{@quiz.id} a", text: 'Retake'
  end

  test 'filters results by period' do
    old = create(:evaluation, :completed, user: @user, quiz: @quiz, completed_at: 2.weeks.ago)
    sign_in_as @user

    get dashboard_path(period: 'week')

    assert_select 'a.button.active', text: 'Week'
    assert_select "#evaluation_#{old.id}", count: 0
  end
end
