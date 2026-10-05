# frozen_string_literal: true

class Questions::SaveQuestion
  extend ::LightService::Organizer

  def self.call(question:)
    result = nil

    ActiveRecord::Base.transaction do
      result = with(question:).reduce(actions)
      raise ActiveRecord::Rollback if result.failure?
    end

    result
  end

  def self.actions
    [
      Questions::CollectCorrectAnswers,
      Questions::PersistQuestion,
      Questions::SyncCorrectAnswers,
    ]
  end
end
