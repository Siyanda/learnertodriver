# frozen_string_literal: true

module ApplicationHelper
  include MarkdownRenderable

  def component(name, *args, **kwargs, &block) # rubocop:disable Style/ArgumentsForwarding,Naming/BlockForwarding
    component = name.to_s.camelize.constantize::Component

    render(component.new(*args, **kwargs), &block) # rubocop:disable Style/ArgumentsForwarding,Naming/BlockForwarding
  end

  def title(page_title)
    content_for(:title) { page_title }
  end

  def from_markdown(text)
    MarkdownRenderable.instance_method(:from_markdown).bind(self).call(text)
  end

  def liquidize(content)
    MarkdownRenderable.instance_method(:liquidize).bind(self).call(content)
  end

  def url_contains?(klass, path) # rubocop:disable Naming/PredicateMethod
    klass if request.path.include?(path.to_s)
  end
end
