class Post < ApplicationRecord
  has_many :comments
  belongs_to :author, class_name: "User"

  has_rich_text :content
  has_one_attached :cover_image
  has_many_attached :images

  enum status: %i[published unpublished draft not_set]
end