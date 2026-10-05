# frozen_string_literal: true

module ApplicationHelper
  include MarkdownRenderable
  include ComponentRenderable

  def title(page_title)
    content_for(:title) { page_title }
  end

  def from_markdown(text)
    MarkdownRenderable.instance_method(:from_markdown).bind(self).call(text)
  end

  def liquidize(content)
    MarkdownRenderable.instance_method(:liquidize).bind(self).call(content)
  end

  # Turns one-per-line profile links into anchors. Only http(s) URLs become
  # links, so values like `javascript:` are shown as plain text.
  def profile_links(text)
    text.to_s.lines.map(&:strip).compact_blank.map do |link|
      next link unless link.match?(%r{\Ahttps?://}i)

      link_to link.sub(%r{\Ahttps?://}i, ''), link, rel: 'nofollow noopener', target: '_blank'
    end
  end

  def url_contains?(klass, path) # rubocop:disable Naming/PredicateMethod
    klass if request.path.include?(path.to_s)
  end
end
