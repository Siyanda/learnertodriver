# frozen_string_literal: true

require 'csv'

models =  %w[user post comment page quiz question answer quiz_question_linkage tag]

puts '... seeding new data 💾'

seeds_path = Rails.root.join("db/seeds/modules/import/#{Rails.env}").to_s

models.each do |data|
  seed = File.read(seeds_path + "/data/#{data}.csv")
  csv = CSV.parse(seed, headers: true)

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
  seeds_path = Rails.root.join("db/seeds/modules/import/#{Rails.env}").to_s

  content = File.read(seeds_path + "/content/#{file_name}.markdown")
  markdown.render(content)
end

data = %w[page post comment]

data.each do |model_name|
  require seeds_path + "/generate/#{model_name}.rb"
  puts "#{model_name.camelize.constantize.count} #{model_name.pluralize} created"
end

puts '... attaching images 🖼️'

models =  %w[quiz]

models.each do |_model_name|
  data = File.read("#{seeds_path}/assets/images/image_list.csv")
  image_list = CSV.parse(data, headers: true)

  image_list.each do |image_row|
    model = image_row['model'].camelize.constantize
    search_value = image_row['find_value'].to_s
    search_by = image_row['find_by'].parameterize.underscore.to_sym
    attachment_name = image_row['attachment_name'].to_s
    file_type = image_row['file_type'].to_s
    file_name = image_row['file_name'].to_s

    record = model.find_by!(search_by => search_value)
    record.send(attachment_name).attach(io:           File.open("#{seeds_path}/assets/images/#{image_row['model']}/#{file_name}"),
                                        filename:     file_name,
                                        content_type: file_type)
  end
end
