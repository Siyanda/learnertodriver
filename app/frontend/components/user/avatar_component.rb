# frozen_string_literal: true

class User::AvatarComponent < ApplicationViewComponent
  option :user,       required: true
  option :size,       default: -> { 80 }
  option :html_class, default: -> { 'avatar' }

  def image_url
    if user.avatar.attached?
      url_for(user.avatar.variant(resize_to_limit: [size, size]))
    else
      gravatar_url
    end
  end

  private

  def gravatar_url
    email = user.email_address.to_s.strip.downcase
    hash = Digest::MD5.hexdigest(email)
    "https://www.gravatar.com/avatar/#{hash}?s=#{size}&d=identicon"
  end
end
