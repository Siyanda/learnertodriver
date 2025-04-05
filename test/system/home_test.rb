# frozen_string_literal: true

require 'application_system_test_case'

class HomeTest < ApplicationSystemTestCase
  test 'visiting the root page' do
    visit root_url

    assert_selector 'h1', text: /#{I18n.t('site_name')}/i
  end
end
