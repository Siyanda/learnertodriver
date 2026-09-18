# frozen_string_literal: true

class ApplicationViewComponent < ViewComponentContrib::Base
  extend Dry::Initializer
  include MarkdownRenderable
  include ComponentRenderable

  def stimulus_id
    @stimulus_id ||= self.class.name.sub('::Component', '').underscore.split('/').join('--').tr('_', '-')
  end

  private

  private :component, :collection_component

  def identifier
    @identifier ||= self.class.name.sub('::Component', '').underscore.split('/').join('--')
  end

  alias_method :controller_name, :identifier # rubocop:disable Style/Alias
end
