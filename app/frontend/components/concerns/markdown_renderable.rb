# frozen_string_literal: true

module MarkdownRenderable
  def from_markdown(text)
    options = %i[autolink fenced_code_blocks highlight no_intra_emphasis]
    Markdown.new(text, *options).to_html
  end

  def liquidize(content)
    Liquid::Template.parse(content).render
  end
end
