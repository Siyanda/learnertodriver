# frozen_string_literal: true

require 'test_helper'

class FlaggedIpTest < ActiveSupport::TestCase
  IP_ADDRESS = '41.1.2.3'

  test 'requires a unique ip address' do
    create(:flagged_ip, ip_address: IP_ADDRESS)

    flagged_ip = build(:flagged_ip, ip_address: IP_ADDRESS)

    assert_not flagged_ip.valid?
    assert_includes flagged_ip.errors[:ip_address], 'has already been taken'
  end

  test 'flags an ip only once, keeping the first reason' do
    FlaggedIp.flag(ip_address: IP_ADDRESS, reason: :honeypot)

    assert_no_difference 'FlaggedIp.count' do
      FlaggedIp.flag(ip_address: IP_ADDRESS, reason: :too_fast)
    end
    assert_predicate FlaggedIp.find_by!(ip_address: IP_ADDRESS), :honeypot?
  end
end
