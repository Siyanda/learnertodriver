# frozen_string_literal: true

module BotCheckTestHelper
  def bot_check_params(started_at: 1.minute.ago)
    { ::BotProtection::FILL_TIME_FIELD => ::BotChecks::CheckFillTime.token(started_at:) }
  end
end
