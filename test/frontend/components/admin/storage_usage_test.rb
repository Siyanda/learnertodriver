# frozen_string_literal: true

require 'test_helper'

class Admin::StorageUsage::ComponentTest < ViewComponent::TestCase
  StorageModule = ::Dashboards::CalculateStorageUsage::StorageModule

  setup do
    @modules = [
      StorageModule.new(label: 'Posts', bytes: 3.megabytes, files: 4, recent_bytes: 1.megabyte),
      StorageModule.new(label: 'Users', bytes: 1.megabyte,  files: 1, recent_bytes: 1.megabyte),
    ]
  end

  test 'renders a segment, legend item and row per module' do
    render_inline(Admin::StorageUsage::Component.new(modules: @modules, bytes: 4.megabytes, files: 5))

    assert_text '4 MB used across 5 files'
    assert_selector '.storage-segment.series-0[style="flex-grow: 3145728"]'
    assert_selector '.storage-legend li', count: 2
    assert_selector '.storage-table tbody tr', count: 2
  end

  test 'shows share and growth for each module' do
    render_inline(Admin::StorageUsage::Component.new(modules: @modules, bytes: 4.megabytes, files: 5))

    assert_selector 'tbody tr:first-child', text: /75%.*\+50\.0%/m
    assert_selector 'tbody tr:last-child',  text: /25%.*—/m
  end

  test 'renders an empty state without files' do
    render_inline(Admin::StorageUsage::Component.new(modules: [], bytes: 0, files: 0))

    assert_text 'No files uploaded yet'
    assert_no_selector '.storage-bar'
  end
end
