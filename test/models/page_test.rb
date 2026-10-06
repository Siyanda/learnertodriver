# frozen_string_literal: true

require 'test_helper'

class PageTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
    @page = create(:page, user: @user)
  end

  test 'is valid with valid attributes' do
    assert_predicate @page, :valid?
  end

  test 'is invalid without a title' do
    @page.title = nil

    assert_not @page.valid?
    assert_includes @page.errors[:title], "can't be blank"
  end

  test 'is invalid with an unknown status' do
    @page.status = :archived

    assert_not @page.valid?
    assert_includes @page.errors[:status], 'is not included in the list'
  end

  test 'generates a slug from the title' do
    page = create(:page, user: @user, title: 'Rules of the Road')

    assert_equal 'rules-of-the-road', page.slug
  end

  test 'regenerates slug when title changes' do
    @page.update!(title: 'Renamed Page')

    assert_equal 'renamed-page', @page.slug
  end

  test 'has a parent and children' do
    child = create(:page, user: @user, parent: @page)

    assert_equal @page, child.parent
    assert_equal [child], @page.children.to_a
  end

  test 'destroys children when destroyed' do
    create(:page, user: @user, parent: @page)

    assert_difference 'Page.count', -2 do
      @page.destroy
    end
  end
end
