# frozen_string_literal: true

class EmailSuppressions::RecordPostmarkEvent
  extend ::LightService::Action

  REASONS = { 'Bounce' => :hard_bounce, 'SpamComplaint' => :spam_complaint }.freeze

  expects :record_type, :email_address, :inactive

  executed do |ctx|
    reason = REASONS.fetch(ctx.record_type, nil)
    next unless reason && ctx.inactive && ctx.email_address.present?

    EmailSuppression.find_or_create_by!(email_address: ctx.email_address) { |suppression| suppression.reason = reason }
  end
end
