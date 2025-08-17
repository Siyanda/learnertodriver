require "application_system_test_case"

class Admin::ResponsesTest < ApplicationSystemTestCase
  setup do
    @admin_response = admin_responses(:one)
  end

  test "visiting the index" do
    visit admin_responses_url
    assert_selector "h1", text: "Responses"
  end

  test "should create response" do
    visit admin_responses_url
    click_on "New response"

    fill_in "Answer", with: @admin_response.answer_id
    fill_in "Question", with: @admin_response.question_id
    click_on "Create Response"

    assert_text "Response was successfully created"
    click_on "Back"
  end

  test "should update Response" do
    visit admin_response_url(@admin_response)
    click_on "Edit this response", match: :first

    fill_in "Answer", with: @admin_response.answer_id
    fill_in "Question", with: @admin_response.question_id
    click_on "Update Response"

    assert_text "Response was successfully updated"
    click_on "Back"
  end

  test "should destroy Response" do
    visit admin_response_url(@admin_response)
    click_on "Destroy this response", match: :first

    assert_text "Response was successfully destroyed"
  end
end
