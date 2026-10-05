# frozen_string_literal: true

require 'application_system_test_case'

class Admin::QuestionsTest < ApplicationSystemTestCase
  setup do
    admin = create(:user, :admin)

    visit new_session_url
    fill_in placeholder: 'Enter your email address', with: admin.email_address
    fill_in placeholder: 'Enter your password',      with: 'demo1234'
    click_on 'Sign in'
  end

  test 'creating a question with answers through the nested form' do
    visit new_admin_question_url

    fill_in 'Question', with: 'What does a red octagon mean?'

    click_on 'Add answer'

    answers = all('.nested-fields', visible: true)

    assert_equal 4, answers.size

    answers.first(3).each_with_index do |answer, index|
      within(answer) do
        fill_in 'Answer',      with: %w[Stop Yield Go][index]
        fill_in 'Information', with: 'Signs'
      end
    end

    within(answers.last) { click_on 'Remove' }
    within(answers.first) { check 'Correct' }

    click_on 'Create Question'

    assert_text 'Successfully saved Question'

    question = Question.find_by!(content: 'What does a red octagon mean?')

    assert_equal 3, question.answers.count
    assert_equal(['Stop'], question.correct_answers.map { it.answer.content })
  end
end
