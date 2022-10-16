# frozen_string_literal: true

require 'csv'

models =  %w[user post comment page quiz question answer specification response tag]

puts '... seeding new data 💾'

seeds_path = "#{Rails.root}/db/seeds/modules/import/#{Rails.env}"

models.each do |data|
  seed = File.read(seeds_path + "/data/#{data}.csv")
  csv = CSV.parse(seed, :headers => true)

  model = data.camelize.constantize
  puts "seeding #{model} 🌱"
  csv.each do |row|
    model.create!(row.to_hash)
  end
  puts "#{data.camelize.constantize.count} #{data.pluralize} created"
end

puts '... generating post and page content from markdown 📝'

def rendered_md(file_name)
  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
  seeds_path = "#{Rails.root}/db/seeds/modules/import/#{Rails.env}"

  content = File.read(seeds_path + "/content/#{file_name}.markdown")
  markdown.render(content)
end

data = %w[page post comment]

data.each do |model_name|
  require seeds_path + "/generate/#{model_name}.rb"
  puts "#{model_name.camelize.constantize.count} #{model_name.pluralize} created"
end
