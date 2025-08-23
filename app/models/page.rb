# frozen_string_literal: true

class Page < ApplicationRecord
  extend FriendlyId

  friendly_id :title, use: :slugged

  validates :title, presence: true

  belongs_to :user

  belongs_to :parent, class_name: 'Page', optional: true, inverse_of: :children
  has_many :children, class_name: 'Page', foreign_key: :parent_id, dependent: :destroy, inverse_of: :parent

  enum :status, {
    draft:       0,
    published:   2,
    unpublished: 1,
    restricted:  3,
    removed:     4
  }, validate: true

  def should_generate_new_friendly_id? = slug.blank? || slug_changed?
end
