require "application_system_test_case"

class Admin::QuizQuestionLinkagesTest < ApplicationSystemTestCase
  setup do
    @admin_quiz_question_linkage = admin_quiz_question_linkages(:one)
  end

  test "visiting the index" do
    visit admin_quiz_question_linkages_url
    assert_selector "h1", text: "Quiz question linkages"
  end

  test "should create quiz question linkage" do
    visit admin_quiz_question_linkages_url
    click_on "New quiz question linkage"

    fill_in "Question", with: @admin_quiz_question_linkage.question_id
    fill_in "Quiz", with: @admin_quiz_question_linkage.quiz_id
    click_on "Create Quiz question linkage"

    assert_text "Quiz question linkage was successfully created"
    click_on "Back"
  end

  test "should update Quiz question linkage" do
    visit admin_quiz_question_linkage_url(@admin_quiz_question_linkage)
    click_on "Edit this quiz question linkage", match: :first

    fill_in "Question", with: @admin_quiz_question_linkage.question_id
    fill_in "Quiz", with: @admin_quiz_question_linkage.quiz_id
    click_on "Update Quiz question linkage"

    assert_text "Quiz question linkage was successfully updated"
    click_on "Back"
  end

  test "should destroy Quiz question linkage" do
    visit admin_quiz_question_linkage_url(@admin_quiz_question_linkage)
    click_on "Destroy this quiz question linkage", match: :first

    assert_text "Quiz question linkage was successfully destroyed"
  end
end
