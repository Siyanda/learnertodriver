class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :posts
  has_many :comments

  validates_uniqueness_of :username

  private

  def suggest_username
    # check if username exists if true, suggest a similarname
  end
end
