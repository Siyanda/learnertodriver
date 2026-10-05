# frozen_string_literal: true

require 'test_helper'

class Admin::TagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tag = create(:tag)

    sign_in_as create(:user, :admin)
  end

  test 'renders index, show, new and edit' do
    [admin_tags_path, admin_tag_path(@tag), new_admin_tag_path, edit_admin_tag_path(@tag)].each do |path|
      get path

      assert_response :success
    end
  end

  test 'creates a tag' do
    assert_difference 'Tag.count', 1 do
      post admin_tags_path, params: { tag: { title: 'Signs', status: 'published' } }
    end

    assert_redirected_to admin_tag_path(Tag.find_by!(title: 'Signs'))
  end

  test 'rejects an invalid tag' do
    post admin_tags_path, params: { tag: { title: '' } }

    assert_response :unprocessable_content
  end

  test 'updates a tag' do
    patch admin_tag_path(@tag), params: { tag: { status: 'restricted' } }

    assert_predicate @tag.reload, :restricted?
  end

  test 'destroys a tag along with its taggings' do
    create(:post).tags << @tag

    assert_difference -> { Tag.count } => -1, -> { Tagging.count } => -1 do
      delete admin_tag_path(@tag)
    end
  end
end
