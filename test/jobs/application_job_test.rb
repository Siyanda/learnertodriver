# frozen_string_literal: true

require 'test_helper'

class ApplicationJobTest < ActiveJob::TestCase
  test "application job inherits from ActiveJob::Base" do
    assert_kind_of ActiveJob::Base, ApplicationJob.new
  end
end
