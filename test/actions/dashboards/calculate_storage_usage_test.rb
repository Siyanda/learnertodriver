# frozen_string_literal: true

require 'test_helper'

class Dashboards::CalculateStorageUsageTest < ActiveSupport::TestCase
  setup do
    @post = create(:post)
    @file = file_fixture('avatar.jpg')
  end

  test 'groups file sizes by the record type they are attached to' do
    2.times { @post.images.attach(io: @file.open, filename: 'avatar.jpg') }
    create(:user).avatar.attach(io: @file.open, filename: 'avatar.jpg')

    result = Dashboards::CalculateStorageUsage.execute
    posts  = result.storage_modules.find { |storage_module| storage_module.label == 'Posts' }

    assert_equal %w[Posts Users], result.storage_modules.map(&:label)
    assert_equal [2, @file.size * 2], [posts.files, posts.bytes]
    assert_equal [3, @file.size * 3], [result.storage_files, result.storage_bytes]
  end

  test 'labels blobs without attachments as unattached' do
    ActiveStorage::Blob.create_and_upload!(io: @file.open, filename: 'avatar.jpg')

    assert_equal ['Unattached'], Dashboards::CalculateStorageUsage.execute.storage_modules.map(&:label)
  end

  test 'reports growth from files added in the last 30 days' do
    travel_to(60.days.ago) { @post.images.attach(io: @file.open, filename: 'avatar.jpg') }
    @post.images.attach(io: @file.open, filename: 'avatar.jpg')

    assert_in_delta 100.0, Dashboards::CalculateStorageUsage.execute.storage_modules.first.growth
  end

  test 'returns no modules when nothing is stored' do
    result = Dashboards::CalculateStorageUsage.execute

    assert_empty result.storage_modules
    assert_equal 0, result.storage_bytes
  end
end
