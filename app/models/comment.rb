# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post, touch: true

  scope :visible, -> { where(status: :published) }

  enum :status, {
    draft:       10,
    unpublished: 20,
    published:   30,
    restricted:  40,
    removed:     50
  }, validate: true

  broadcasts_refreshes
end
