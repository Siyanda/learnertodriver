# frozen_string_literal: true

class Questions::PersistQuestion
  extend ::LightService::Action

  expects :question

  executed do |ctx|
    next if ctx.question.save

    ctx.fail_and_return!(ctx.question.errors.full_messages.to_sentence)
  rescue ActiveRecord::InvalidForeignKey
    ctx.fail_and_return!(I18n.t('admin.questions.answer_in_use'))
  end
end
