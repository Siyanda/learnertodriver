require "test_helper"

class Admin::QuizzesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_quiz = admin_quizzes(:one)
  end

  test "should get index" do
    get admin_quizzes_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_quiz_url
    assert_response :success
  end

  test "should create admin_quiz" do
    assert_difference("Admin::Quiz.count") do
      post admin_quizzes_url, params: { admin_quiz: { description: @admin_quiz.description, duration: @admin_quiz.duration, information: @admin_quiz.information, published_at: @admin_quiz.published_at, slug: @admin_quiz.slug, status: @admin_quiz.status, title: @admin_quiz.title } }
    end

    assert_redirected_to admin_quiz_url(Admin::Quiz.last)
  end

  test "should show admin_quiz" do
    get admin_quiz_url(@admin_quiz)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_quiz_url(@admin_quiz)
    assert_response :success
  end

  test "should update admin_quiz" do
    patch admin_quiz_url(@admin_quiz), params: { admin_quiz: { description: @admin_quiz.description, duration: @admin_quiz.duration, information: @admin_quiz.information, published_at: @admin_quiz.published_at, slug: @admin_quiz.slug, status: @admin_quiz.status, title: @admin_quiz.title } }
    assert_redirected_to admin_quiz_url(@admin_quiz)
  end

  test "should destroy admin_quiz" do
    assert_difference("Admin::Quiz.count", -1) do
      delete admin_quiz_url(@admin_quiz)
    end

    assert_redirected_to admin_quizzes_url
  end
end
