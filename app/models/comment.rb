# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post, touch: true

  broadcasts_refreshes

  enum :status, { draft: 0, unpublished: 1, published: 2, restricted: 3, removed: 4 }, validate: true

  scope :visible, -> { where(status: :published) }
end
