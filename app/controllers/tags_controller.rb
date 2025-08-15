# frozen_string_literal: true

class TagsController < ApplicationController
  allow_unauthenticated_access

  def show
    @tag = Tag.friendly.find(params[:id])
  end
end
