# frozen_string_literal: true

require 'test_helper'

class Evaluations::PrepareUpdateAttributesTest < ActiveSupport::TestCase
  test 'sets update_attrs from params when commit is blank' do
    params = { score: 10 }
    ctx    = Evaluations::PrepareUpdateAttributes.execute(params:, commit: nil)

    assert_equal params, ctx.update_attrs
  end

  test 'merges completed status and completed_at when commit is present' do
    freeze_time do
      params = { score: 10 }
      ctx    = Evaluations::PrepareUpdateAttributes.execute(params:, commit: 'finish')

      assert_equal :completed, ctx.update_attrs[:status]
      assert_equal Time.current, ctx.update_attrs[:completed_at]
    end
  end

  test 'does not modify original params when commit is present' do
    params = { score: 10 }
    Evaluations::PrepareUpdateAttributes.execute(params:, commit: 'finish')

    assert_equal({ score: 10 }, params)
  end
end
