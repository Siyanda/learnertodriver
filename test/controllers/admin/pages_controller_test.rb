# frozen_string_literal: true

require 'test_helper'

class Admin::PagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = create(:user, :admin)
    @page  = create(:page)

    sign_in_as @admin
  end

  test 'renders index, show, new and edit' do
    [admin_pages_path, admin_page_path(@page), new_admin_page_path, edit_admin_page_path(@page)].each do |path|
      get path

      assert_response :success
    end
  end

  test 'creates a page' do
    assert_difference 'Page.count', 1 do
      post admin_pages_path, params: { page: { title: 'About', user_id: @admin.id, parent_id: @page.id,
                                               status: 'draft' } }
    end

    assert_equal @page, Page.order(:id).last.parent
  end

  test 'rejects an invalid page' do
    post admin_pages_path, params: { page: { title: '', user_id: @admin.id } }

    assert_response :unprocessable_content
  end

  test 'updates a page' do
    patch admin_page_path(@page), params: { page: { status: 'unpublished' } }

    assert_predicate @page.reload, :unpublished?
  end

  test 'destroys a page' do
    assert_difference 'Page.count', -1 do
      delete admin_page_path(@page)
    end

    assert_redirected_to admin_pages_path
  end
end
