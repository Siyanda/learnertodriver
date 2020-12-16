class Post < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_many :comments

  enum status: %i[published unpublished draft not_set]

  has_one_attached :cover_image
  has_many_attached :images
  has_rich_text :content
end
