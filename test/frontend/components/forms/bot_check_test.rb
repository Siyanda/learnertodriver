# frozen_string_literal: true

require 'test_helper'

class Forms::BotCheck::ComponentTest < ViewComponent::TestCase
  test 'renders a hidden honeypot and a signed start time' do
    page = render_inline(Forms::BotCheck::Component.new(turnstile_site_key: nil))

    assert_equal '-1', page.css('.bot-check-field input[name="website"]').first['tabindex']
    assert_predicate page.css('input[type="hidden"][name="form_started_at"]').first['value'], :present?
  end

  test 'leaves out the Turnstile widget when no site key is set' do
    page = render_inline(Forms::BotCheck::Component.new(turnstile_site_key: nil))

    assert_empty page.css('.bot-check-widget')
  end

  test 'renders the Turnstile widget with the site key' do
    page = render_inline(Forms::BotCheck::Component.new(turnstile_site_key: '1x00000000000000000000AA'))

    assert_equal '1x00000000000000000000AA', page.css('.bot-check-widget').first['data-forms--bot-check-site-key-value']
  end
end
