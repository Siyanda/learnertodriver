# frozen_string_literal: true

class Evaluations::PrepareUpdateAttributes
  extend ::LightService::Action

  expects  :params, :commit
  promises :update_attrs

  executed do |ctx|
    ctx.update_attrs = ctx.params

    next if ctx.commit.blank?

    ctx.update_attrs = ctx.update_attrs.merge(status: :completed, completed_at: Time.current)
  end
end
