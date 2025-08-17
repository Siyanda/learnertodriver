require "application_system_test_case"

class Admin::EvaluationsTest < ApplicationSystemTestCase
  setup do
    @admin_evaluation = admin_evaluations(:one)
  end

  test "visiting the index" do
    visit admin_evaluations_url
    assert_selector "h1", text: "Evaluations"
  end

  test "should create evaluation" do
    visit admin_evaluations_url
    click_on "New evaluation"

    fill_in "Completed at", with: @admin_evaluation.completed_at
    fill_in "Last choice", with: @admin_evaluation.last_choice_id
    fill_in "Quiz", with: @admin_evaluation.quiz_id
    fill_in "Score", with: @admin_evaluation.score
    fill_in "Started at", with: @admin_evaluation.started_at
    fill_in "Status", with: @admin_evaluation.status
    fill_in "User", with: @admin_evaluation.user_id
    click_on "Create Evaluation"

    assert_text "Evaluation was successfully created"
    click_on "Back"
  end

  test "should update Evaluation" do
    visit admin_evaluation_url(@admin_evaluation)
    click_on "Edit this evaluation", match: :first

    fill_in "Completed at", with: @admin_evaluation.completed_at.to_s
    fill_in "Last choice", with: @admin_evaluation.last_choice_id
    fill_in "Quiz", with: @admin_evaluation.quiz_id
    fill_in "Score", with: @admin_evaluation.score
    fill_in "Started at", with: @admin_evaluation.started_at.to_s
    fill_in "Status", with: @admin_evaluation.status
    fill_in "User", with: @admin_evaluation.user_id
    click_on "Update Evaluation"

    assert_text "Evaluation was successfully updated"
    click_on "Back"
  end

  test "should destroy Evaluation" do
    visit admin_evaluation_url(@admin_evaluation)
    click_on "Destroy this evaluation", match: :first

    assert_text "Evaluation was successfully destroyed"
  end
end
