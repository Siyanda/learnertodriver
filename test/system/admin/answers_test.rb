require "application_system_test_case"

class Admin::AnswersTest < ApplicationSystemTestCase
  setup do
    @admin_answer = admin_answers(:one)
  end

  test "visiting the index" do
    visit admin_answers_url
    assert_selector "h1", text: "Answers"
  end

  test "should create answer" do
    visit admin_answers_url
    click_on "New answer"

    fill_in "Content", with: @admin_answer.content
    fill_in "Information", with: @admin_answer.information
    fill_in "Name", with: @admin_answer.name
    fill_in "Question", with: @admin_answer.question_id
    fill_in "Value", with: @admin_answer.value
    click_on "Create Answer"

    assert_text "Answer was successfully created"
    click_on "Back"
  end

  test "should update Answer" do
    visit admin_answer_url(@admin_answer)
    click_on "Edit this answer", match: :first

    fill_in "Content", with: @admin_answer.content
    fill_in "Information", with: @admin_answer.information
    fill_in "Name", with: @admin_answer.name
    fill_in "Question", with: @admin_answer.question_id
    fill_in "Value", with: @admin_answer.value
    click_on "Update Answer"

    assert_text "Answer was successfully updated"
    click_on "Back"
  end

  test "should destroy Answer" do
    visit admin_answer_url(@admin_answer)
    click_on "Destroy this answer", match: :first

    assert_text "Answer was successfully destroyed"
  end
end
