# frozen_string_literal: true

require 'test_helper'

class ResponseTest < ActiveSupport::TestCase
  test 'is valid with valid attributes' do
    assert_predicate build(:response), :valid?
  end

  test 'requires an answer and question' do
    response = Response.new

    assert_not response.valid?
    assert_includes response.errors[:answer], 'must exist'
    assert_includes response.errors[:question], 'must exist'
  end
end
