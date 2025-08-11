# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

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
    options = %i[autolink fenced_code_blocks highlight no_intra_emphasis]
    Markdown.new(text, *options).to_html
  end

  def liquidize(content)
    Liquid::Template.parse(content).render
  end

  def time_ago_span(datetime, html_class: 'date-value')
    content_tag(
      :span,
      nil,
      data:  {
        controller:                        'dayjs-time-ago',
        'dayjs-time-ago-target':           'formattedTime',
        'dayjs-time-ago-time-stamp-value': datetime.iso8601
      },
      class: html_class
    )
  end

  def duration_value_span(duration, html_class: 'duration-value')
    content_tag(
      :span,
      nil,
      data:  {
        controller:                           'dayjs-to-duration',
        'dayjs-to-duration-target':           'formattedTime',
        'dayjs-to-duration-time-stamp-value': duration
      },
      class: html_class
    )
  end

  def gravatar_url(email_address, options = {})
    require 'digest/md5'
    hash = Digest::MD5.hexdigest(email_address)
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
