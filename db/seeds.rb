require 'csv'

models =  %w[user page post comment quiz question answer specification response]

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

# puts '... generating posts and pages from markdown 📝'

# def rendered_md(file_name)
#   markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
#   file = "#{Rails.root}/db/seeds/modules/import/#{Rails.env}/content/comment/#{file_name}.markdown"

#   content = File.read(file)
#   markdown.render(content)
# end

# files = [
#   { 'content' => rendered_md('first-comment'), 'post_id' => Post.first.id, 'user_id' => User.first.id }
# ]

# files.each do |data|
#   Comment.create!(data)
# end
