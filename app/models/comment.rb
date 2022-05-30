# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  enum status: { draft: 0, unpublished: 1, published: 2, restricted: 3, removed: 4 }
end
