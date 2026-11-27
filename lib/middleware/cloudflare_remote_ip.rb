# frozen_string_literal: true

require 'ipaddr'

# Cloudflare sends the visitor's address in CF-Connecting-IP. The proxy in
# front of Puma replaces Cloudflare's X-Forwarded-For with the edge it
# connected from, so ActionDispatch::RemoteIp resolves every request to a
# Cloudflare edge. When it does, the request really came through Cloudflare
# and CF-Connecting-IP can be trusted; a request that reached the server
# directly keeps its own address, whatever headers it sends.
class CloudflareRemoteIp
  RANGES = %w[
    173.245.48.0/20
    103.21.244.0/22
    103.22.200.0/22
    103.31.4.0/22
    141.101.64.0/18
    108.162.192.0/18
    190.93.240.0/20
    188.114.96.0/20
    197.234.240.0/22
    198.41.128.0/17
    162.158.0.0/15
    104.16.0.0/13
    104.24.0.0/14
    172.64.0.0/13
    131.0.72.0/22
    2400:cb00::/32
    2606:4700::/32
    2803:f800::/32
    2405:b500::/32
    2405:8100::/32
    2a06:98c0::/29
    2c0f:f248::/32
  ].map { IPAddr.new(it) }.freeze

  def self.edge?(ip)
    address = IPAddr.new(ip.to_s)
    RANGES.any? { it.include?(address) }
  rescue IPAddr::Error
    false
  end

  def initialize(app)
    @app = app
  end

  def call(env)
    request = ActionDispatch::Request.new(env)
    if self.class.edge?(request.remote_ip) && (client_ip = connecting_ip(request))
      request.remote_ip = client_ip
    end

    @app.call(env)
  end

  private

  def connecting_ip(request)
    IPAddr.new(request.get_header('HTTP_CF_CONNECTING_IP').to_s).to_s
  rescue IPAddr::Error
    nil
  end
end
