class Notification < ApplicationRecord
  belongs_to :notifiable, polymorphic: true
end
