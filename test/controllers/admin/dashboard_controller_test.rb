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

  test 'renders activity trends and storage usage' do
    create(:post).images.attach(io: file_fixture('avatar.jpg').open, filename: 'avatar.jpg')

    get admin_path

    assert_select '.activity-cards .stat-card', 4
    assert_select '.storage-table tbody tr', text: /Posts/
  end
end
