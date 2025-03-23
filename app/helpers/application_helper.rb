# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def current_user
    Current.user
  end

  def title(page_title)
    content_for(:title) { page_title }
  end

  def url_contains?(klass, path)
    klass if request.path.include?(path.to_s)
  end

  def inline_svg(path)
    File.open("app/assets/images/svg/#{path}", 'rb') do |file|
      raw file.read
    end
  end

  def from_markdown(text)
    options = [:autolink, :fenced_code_blocks, :highlight, :no_intra_emphasis]
    Markdown.new(text, *options).to_html
  end

  def meta_tag(name, content)
    tag.meta(name:, content:) unless content.nil?
  end

  def liquidize(content)
    Liquid::Template.parse(content).render
  end

  def gravatar_url(email, options = {})
    require 'digest/md5'
    hash = Digest::MD5.hexdigest(email)
    url = "https://www.gravatar.com/avatar/#{hash}"
    options.each do |option|
      url += option == options.first ? '?' : '&'
      key = option[0].to_s
      value = option[1].to_s
      url += "#{key}=#{value}"
    end
    url
  end
end
