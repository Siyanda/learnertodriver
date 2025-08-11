# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def destroy?
    owner?
  end
end
