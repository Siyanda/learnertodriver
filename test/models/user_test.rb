# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  include ActionDispatch::TestProcess::FixtureFile

  test 'is valid with valid attributes' do
    user = User.new(username: 'johndoe', email_address: 'john@example.com', password: 'password')
    assert user.valid?
  end

  test 'is invalid without unique username' do
    User.create!(username: 'johndoe', email_address: 'john@example.com', password: 'password')
    duplicate = User.new(username: 'johndoe', email_address: 'john2@example.com', password: 'password')
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:username], 'has already been taken'
  end

  test 'normalizes email address to lowercase and stripped' do
    user = User.new(username: 'jane', email_address: '  Jane@Example.com  ', password: 'password')
    user.valid?
    assert_equal 'jane@example.com', user.email_address
  end

  test 'slug is generated from username' do
    user = User.create!(username: 'Jane Doe', email_address: 'jane@example.com', password: 'password')
    assert_equal 'jane-doe', user.slug
  end

  test 'has expected roles and statuses' do
    assert_includes User.roles.keys, 'admin'
    assert_includes User.statuses.keys, 'active'
  end

  test 'rejects avatar over 1MB' do
    user = User.new(username: 'bigfile', email_address: 'big@example.com', password: 'password')
    file = fixture_file_upload('avatar.jpg', 'image/jpeg')
    user.avatar.attach(file)

    user.avatar.blob.byte_size = 5.megabytes
    user.valid?

    assert_includes user.errors[:avatar], 'file is too large, the maximum is 4Mb'
  end

  test 'rejects avatar with unsupported content type' do
    user = User.new(username: 'wrongtype', email_address: 'wrong@example.com', password: 'password')
    file = fixture_file_upload('fake.txt', 'text/plain')
    user.avatar.attach(file)

    user.valid?
    assert_includes user.errors[:avatar], 'must be a JPEG or PNG'
  end

  test 'accepts a valid JPEG avatar under 1MB' do
    user = User.new(username: 'validuser', email_address: 'valid@example.com', password: 'password')
    file = fixture_file_upload('avatar.jpg', 'image/jpeg')
    user.avatar.attach(file)

    user.avatar.blob.byte_size = 500.kilobytes
    user.valid?

    assert_empty user.errors[:avatar]
  end
end
