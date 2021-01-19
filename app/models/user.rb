class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :posts
  has_many :comments

  extend FriendlyId
    friendly_id :username, use: :slugged

  validates_uniqueness_of :username


  def should_generate_new_friendly_id?
    slug.blank? || username_changed?
  end

  private

  def suggest_username
    # TODO check if username exists if true, suggest a similarname
  end
end