module ApplicationHelper
  include Pagy::Frontend

  def gravatar_url(email, options = {})
    require 'digest/md5'
    hash = Digest::MD5.hexdigest(email)
    url = "https://www.gravatar.com/avatar/#{hash}"
    options.each do |option|
      option == options.first ? url += '?' : url += '&'
      key = option[0].to_s
      value = option[1].to_s
      url += key + '=' + value
    end
    url
  end

  def set_active?(key, condition)
    key.to_s if condition.to_s
  end

  def contains?(key, param)
    key.to_s if params.value?(param)
  end

  # "active" classes for menu links
  def current?(key, path)
    "#{key}" if current_page? path
  end

  def link_to_active(text, destination, options = {})
    match_text = options.delete(:match_text)

    classes = options[:class].present? ? options[:class].split(" ") : []
    classes << "active" if request.fullpath.downcase == destination.downcase || (match_text && request.fullpath.downcase.include?(match_text.downcase))

    options = options.except(:class)
    options.merge!(:class => classes.join(" ")) unless classes.empty?

    link_to(text, destination, options)
  end

  # Pretty Page Title
  def title(page_title)
    content_for(:title) { page_title }
  end

  # inline SVG
  def inline_svg(path)
    File.open("app/assets/images/svg/#{path}", 'rb') do |file|
      raw file.read
    end
  end
end
