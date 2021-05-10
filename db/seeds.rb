require 'csv'

models =  %w[user quiz question answer specification response]

puts '... deleting all existing data 🗑'

models.reverse.each { |m|
  m.camelize.constantize.delete_all
}

# seed_modules

puts '... seeding new data 💾'

models.each do |data|
  seed = File.read(File.dirname(__FILE__)+"/seeds/modules/import/#{Rails.env}/data/#{data}.csv")
  csv = CSV.parse(seed, :headers => true)

  model = data.camelize.constantize
  puts "seeding #{model} 🌱"
  csv.each do |row|
    model.create!(
      row.to_hash)
  end
  puts "#{data.camelize.constantize.count} #{data.pluralize} created"
end

puts '... generating post and page content from markdown 📝'

def rendered_md(file_name)
  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
  file = "#{Rails.root}/db/seeds/modules/import/#{Rails.env}/content/#{file_name}.markdown"

  content = File.read(file)
  markdown.render(content)
end

data = %w[page post comment]

data.each do |model_name|
   require File.expand_path(File.dirname(__FILE__))+"/seeds/modules/import/#{Rails.env}/generate/#{model_name}.rb"
   puts "#{model_name.camelize.constantize.count} #{model_name.pluralize} created"
end
