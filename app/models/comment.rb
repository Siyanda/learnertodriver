# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post, touch: true

  scope :visible, -> { where(status: :published) }

  enum :status, {
    draft:       0,
    unpublished: 1,
    published:   2,
    restricted:  3,
    removed:     4
  }, validate: true

  broadcasts_refreshes
end
