# frozen_string_literal: true

class ServiceWorkerController < ApplicationController
  protect_from_forgery except: :service_worker
  allow_unauthenticated_access

  def service_worker; end

  def manifest; end

  def offline; end
end
