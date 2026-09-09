# frozen_string_literal: true

class ApplicationViewComponent < ViewComponentContrib::Base
  extend Dry::Initializer
  include MarkdownRenderable

  def stimulus_id
    @_stimulus_id ||= self.class.name.sub('::Component', '').underscore.split('/').join('--').tr('_', '-')
  end

  private

  def component(name, *args, **kwargs, &block) # rubocop:disable Style/ArgumentsForwarding,Naming/BlockForwarding
    component = name.to_s.camelize.constantize::Component

    render(component.new(*args, **kwargs), &block) # rubocop:disable Style/ArgumentsForwarding,Naming/BlockForwarding
  end

  def collection_component(name, *args, **kwargs, &block) # rubocop:disable Style/ArgumentsForwarding,Naming/BlockForwarding
    component = name.to_s.camelize.constantize::Component

    render(component.with_collection(*args, **kwargs), &block) # rubocop:disable Style/ArgumentsForwarding,Naming/BlockForwarding
  end

  def identifier
    @_identifier ||= self.class.name.sub('::Component', '').underscore.split('/').join('--')
  end

  alias_method :controller_name, :identifier # rubocop:disable Style/Alias
end
