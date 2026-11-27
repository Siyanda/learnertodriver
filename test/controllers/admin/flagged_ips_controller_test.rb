# frozen_string_literal: true

require 'test_helper'

class Admin::FlaggedIpsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @flagged_ip = create(:flagged_ip, ip_address: '41.1.2.3')

    sign_in_as create(:user, :admin)
  end

  test 'lists flagged ips with a cloudflare download link' do
    get admin_flagged_ips_path

    assert_response :success
    assert_select "#flagged_ip_#{@flagged_ip.id}"
    assert_select "a[href='#{admin_flagged_ips_path(format: :csv)}']"
  end

  test 'downloads the flagged ips as a cloudflare list' do
    create(:flagged_ip, :too_fast, ip_address: '2001:db8::1')

    get admin_flagged_ips_path(format: :csv)

    assert_equal "41.1.2.3,honeypot\n2001:db8::1,too_fast\n", response.body
  end

  test 'removes a flagged ip' do
    assert_difference 'FlaggedIp.count', -1 do
      delete admin_flagged_ip_path(@flagged_ip)
    end

    assert_redirected_to admin_flagged_ips_path
  end
end
