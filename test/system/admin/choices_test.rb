require "application_system_test_case"

class Admin::ChoicesTest < ApplicationSystemTestCase
  setup do
    @admin_choice = admin_choices(:one)
  end

  test "visiting the index" do
    visit admin_choices_url
    assert_selector "h1", text: "Choices"
  end

  test "should create choice" do
    visit admin_choices_url
    click_on "New choice"

    fill_in "Answer", with: @admin_choice.answer_id
    fill_in "Content", with: @admin_choice.content
    fill_in "Evaluation", with: @admin_choice.evaluation_id
    fill_in "Name", with: @admin_choice.name
    fill_in "Position", with: @admin_choice.position
    fill_in "Question", with: @admin_choice.question_id
    fill_in "Value", with: @admin_choice.value
    click_on "Create Choice"

    assert_text "Choice was successfully created"
    click_on "Back"
  end

  test "should update Choice" do
    visit admin_choice_url(@admin_choice)
    click_on "Edit this choice", match: :first

    fill_in "Answer", with: @admin_choice.answer_id
    fill_in "Content", with: @admin_choice.content
    fill_in "Evaluation", with: @admin_choice.evaluation_id
    fill_in "Name", with: @admin_choice.name
    fill_in "Position", with: @admin_choice.position
    fill_in "Question", with: @admin_choice.question_id
    fill_in "Value", with: @admin_choice.value
    click_on "Update Choice"

    assert_text "Choice was successfully updated"
    click_on "Back"
  end

  test "should destroy Choice" do
    visit admin_choice_url(@admin_choice)
    click_on "Destroy this choice", match: :first

    assert_text "Choice was successfully destroyed"
  end
end
