# frozen_string_literal: true

require 'better_html'

# Based on https://github.com/Shopify/better-html#testing-for-valid-html-and-erb
RSpec.describe 'ERB templates' do # rubocop:disable RSpec/DescribeClass
  Dir[
    Rails.root.join('app/views/**/{*.htm,*.html,*.htm.erb,*.html.erb,*.html+*.erb}')
  ].each do |filename|
    describe Pathname.new(filename).relative_path_from(Rails.root) do
      it 'is valid' do
        expect(BetterHtml::BetterErb::ErubiImplementation.new(File.read(filename)).validate!).to be_nil
      end
    end
  end
end
