# frozen_string_literal: true

module ComponentRenderable
  def component(name, *args, **kwargs, &block) # rubocop:disable Style/ArgumentsForwarding,Naming/BlockForwarding
    render(component_class(name).new(*args, **kwargs), &block) # rubocop:disable Style/ArgumentsForwarding,Naming/BlockForwarding
  end

  def collection_component(name, *args, **kwargs, &block) # rubocop:disable Style/ArgumentsForwarding,Naming/BlockForwarding
    render(component_class(name).with_collection(*args, **kwargs), &block) # rubocop:disable Style/ArgumentsForwarding,Naming/BlockForwarding
  end

  private

  def component_class(name)
    name.to_s.camelize.constantize::Component
  end
end
