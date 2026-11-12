# frozen_string_literal: true

require 'test_helper'

class Admin::DirectUploadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @blob_params = { blob: { filename: 'notes.txt', byte_size: 5, checksum: Digest::MD5.base64digest('hello'), content_type: 'text/plain' } }
  end

  test 'guests cannot create direct uploads' do
    assert_no_difference 'ActiveStorage::Blob.count' do
      post rails_direct_uploads_path, params: @blob_params
    end

    assert_redirected_to new_session_path
  end

  test 'non-admins cannot create direct uploads' do
    sign_in_as create(:user)

    post rails_direct_uploads_path, params: @blob_params

    assert_response :forbidden
  end

  test 'admins can create direct uploads' do
    sign_in_as create(:user, :admin)

    assert_difference 'ActiveStorage::Blob.count', 1 do
      post rails_direct_uploads_path, params: @blob_params
    end
  end
end
