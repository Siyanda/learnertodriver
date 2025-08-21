require "application_system_test_case"

class Admin::CorrectAnswersTest < ApplicationSystemTestCase
  setup do
    @admin_correct_answer = admin_correct_answers(:one)
  end

  test "visiting the index" do
    visit admin_correct_answers_url
    assert_selector "h1", text: "Correct answers"
  end

  test "should create correct answer" do
    visit admin_correct_answers_url
    click_on "New correct answer"

    fill_in "Answer", with: @admin_correct_answer.answer_id
    fill_in "Question", with: @admin_correct_answer.question_id
    click_on "Create Correct answer"

    assert_text "Correct answer was successfully created"
    click_on "Back"
  end

  test "should update Correct answer" do
    visit admin_correct_answer_url(@admin_correct_answer)
    click_on "Edit this correct answer", match: :first

    fill_in "Answer", with: @admin_correct_answer.answer_id
    fill_in "Question", with: @admin_correct_answer.question_id
    click_on "Update Correct answer"

    assert_text "Correct answer was successfully updated"
    click_on "Back"
  end

  test "should destroy Correct answer" do
    visit admin_correct_answer_url(@admin_correct_answer)
    click_on "Destroy this correct answer", match: :first

    assert_text "Correct answer was successfully destroyed"
  end
end
