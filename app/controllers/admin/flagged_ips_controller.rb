# frozen_string_literal: true

class Admin::FlaggedIpsController < Admin::ResourcesController
  def index
    respond_to do |format|
      format.html { super }
      format.csv { send_data cloudflare_list, filename: "flagged-ips-#{Date.current}.csv" }
    end
  end

  private

  def resource_class = FlaggedIp

  def default_sort = 'created_at desc'

  def search_attribute = :ip_address_cont

  def index_columns = %i[ip_address reason created_at]

  def cloudflare_list
    FlaggedIp.order(:created_at).map { |flagged_ip| "#{flagged_ip.ip_address},#{flagged_ip.reason}\n" }.join
  end
end
