# frozen_string_literal: true

require 'test_helper'

class Quiz::CoverImage::ComponentTest < ViewComponent::TestCase
  def test_renders_ad
    quiz = create(:quiz)

    render_inline(Quiz::CoverImage::Component.new(quiz:))

    assert_selector 'h2', text: quiz.title
  end
end
