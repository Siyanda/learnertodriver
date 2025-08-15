# frozen_string_literal: true

class PagesController < ApplicationController
  allow_unauthenticated_access

  def show
    @page = Page.friendly.find(params[:id]) || not_found!
  end
end
