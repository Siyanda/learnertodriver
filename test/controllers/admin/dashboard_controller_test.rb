# frozen_string_literal: true

require 'test_helper'

class Admin::DashboardControllerTest < ActionDispatch::IntegrationTest
  setup { sign_in_as create(:user, :admin) }

  test 'renders counts and recent activity' do
    evaluation = create(:evaluation, :completed)

    get admin_path

    assert_response :success
    assert_select '.stat-card', minimum: 5
    assert_select "#evaluation_#{evaluation.id}"
  end
end
