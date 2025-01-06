# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'generates new slug when username is updated' do
    u = create(:user, username: nil)
    u.username = 'sadiomane'
    u.save

    assert_equal 'sadiomane', u.slug
  end

  test 'validates acceptable avatar image size and type' do
    user = create(:user)

    oversized_avatar = fixture_file_upload('test/fixtures/files/oversized_image.jpg', 'image/jpeg')
    oversized_avatar.stub(:byte_size, 2.megabytes) do
      user.avatar.attach(oversized_avatar)
      refute user.valid?
      assert_includes user.errors[:avatar], 'file is too larger than 1Mb'
    end

    invalid_type_avatar = fixture_file_upload('test/fixtures/files/invalid_type.pdf', 'application/pdf')
    user.avatar.attach(invalid_type_avatar)
    refute user.valid?
    assert_includes user.errors[:avatar], 'must be a JPEG or PNG'

    valid_avatar = fixture_file_upload('test/fixtures/files/valid_image.jpg', 'image/jpeg')
    user.avatar.attach(valid_avatar)
    assert user.valid?
  end
end
