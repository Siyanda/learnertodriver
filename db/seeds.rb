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
  puts "seeding #{model}"
  csv.each do |row|
    model.create!(
      row.to_hash)
  end
  puts "#{data.camelize.constantize.count} #{data.pluralize} created"
end
