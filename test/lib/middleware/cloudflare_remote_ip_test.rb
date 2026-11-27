# frozen_string_literal: true

require 'test_helper'

class CloudflareRemoteIpTest < ActiveSupport::TestCase
  CLIENT_IP = '203.0.113.7'
  EDGE_IP   = '172.71.172.232'
  PROXY_IP  = '10.0.1.5'

  test 'uses CF-Connecting-IP for requests from a Cloudflare edge' do
    assert_equal CLIENT_IP, remote_ip(forwarded_for: EDGE_IP, connecting_ip: CLIENT_IP)
  end

  test 'uses CF-Connecting-IP for requests from an IPv6 Cloudflare edge' do
    assert_equal CLIENT_IP, remote_ip(forwarded_for: '2a06:98c0:3600::103', connecting_ip: CLIENT_IP)
  end

  test 'ignores CF-Connecting-IP for requests that did not come through Cloudflare' do
    assert_equal '198.51.100.9', remote_ip(forwarded_for: '198.51.100.9', connecting_ip: CLIENT_IP)
  end

  test 'keeps the edge address when CF-Connecting-IP is missing' do
    assert_equal EDGE_IP, remote_ip(forwarded_for: EDGE_IP)
  end

  test 'keeps the edge address when CF-Connecting-IP is not an IP address' do
    assert_equal EDGE_IP, remote_ip(forwarded_for: EDGE_IP, connecting_ip: 'not-an-ip')
  end

  test 'leaves a client address resolved from X-Forwarded-For alone' do
    assert_equal CLIENT_IP, remote_ip(forwarded_for: "#{CLIENT_IP}, #{EDGE_IP}", connecting_ip: '198.51.100.9')
  end

  test 'runs after ActionDispatch::RemoteIp in the app' do
    middlewares = Rails.application.middleware.middlewares

    assert_equal middlewares.index(ActionDispatch::RemoteIp) + 1, middlewares.index(CloudflareRemoteIp)
  end

  private

  def remote_ip(forwarded_for:, connecting_ip: nil)
    env = Rack::MockRequest.env_for('/', 'REMOTE_ADDR' => PROXY_IP, 'HTTP_X_FORWARDED_FOR' => forwarded_for)
    env['HTTP_CF_CONNECTING_IP'] = connecting_ip if connecting_ip

    seen    = nil
    app     = lambda do |inner_env|
      seen = ActionDispatch::Request.new(inner_env).remote_ip
      [200, {}, []]
    end
    proxies = Rails.application.config.action_dispatch.trusted_proxies
    ActionDispatch::RemoteIp.new(CloudflareRemoteIp.new(app), true, proxies).call(env)
    seen
  end
end
