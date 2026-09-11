# frozen_string_literal: true

class Quiz::PreviewCard::Component < ApplicationViewComponent
  with_collection_parameter :quiz

  option :quiz

  delegate :title, to: :quiz
end
