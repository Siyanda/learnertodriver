require "application_system_test_case"

class Admin::QuizzesTest < ApplicationSystemTestCase
  setup do
    @admin_quiz = admin_quizzes(:one)
  end

  test "visiting the index" do
    visit admin_quizzes_url
    assert_selector "h1", text: "Quizzes"
  end

  test "should create quiz" do
    visit admin_quizzes_url
    click_on "New quiz"

    fill_in "Description", with: @admin_quiz.description
    fill_in "Duration", with: @admin_quiz.duration
    fill_in "Information", with: @admin_quiz.information
    fill_in "Published at", with: @admin_quiz.published_at
    fill_in "Slug", with: @admin_quiz.slug
    fill_in "Status", with: @admin_quiz.status
    fill_in "Title", with: @admin_quiz.title
    click_on "Create Quiz"

    assert_text "Quiz was successfully created"
    click_on "Back"
  end

  test "should update Quiz" do
    visit admin_quiz_url(@admin_quiz)
    click_on "Edit this quiz", match: :first

    fill_in "Description", with: @admin_quiz.description
    fill_in "Duration", with: @admin_quiz.duration
    fill_in "Information", with: @admin_quiz.information
    fill_in "Published at", with: @admin_quiz.published_at.to_s
    fill_in "Slug", with: @admin_quiz.slug
    fill_in "Status", with: @admin_quiz.status
    fill_in "Title", with: @admin_quiz.title
    click_on "Update Quiz"

    assert_text "Quiz was successfully updated"
    click_on "Back"
  end

  test "should destroy Quiz" do
    visit admin_quiz_url(@admin_quiz)
    click_on "Destroy this quiz", match: :first

    assert_text "Quiz was successfully destroyed"
  end
end
