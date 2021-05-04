
puts '... generating posts and pages from markdown 📝'

def rendered_md(file_name)
  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
  file = "#{Rails.root}/db/seeds/modules/import/#{Rails.env}/content/page/#{file_name}.markdown"

  content = File.read(file)
  markdown.render(content)
end

files = [
  {"title"=> "About Us","content"=> rendered_md("about"),"slug"=> "about","status"=> "published","editor_id"=> User.first.id,"parent_id"=> ""},
  {"title"=> "Terms & Conditions","content"=> rendered_md("terms"),"slug"=> "terms","status"=> "published","editor_id"=> User.first.id,"parent_id"=> ""},
  {"title"=> "Use Restrictions Policy","content"=> rendered_md("abuse"),"slug"=> "abuse","status"=> "published","editor_id"=> User.first.id,"parent_id"=> ""},
  {"title"=> "Account Ownership Information","content"=> rendered_md("account-ownership-information"),"slug"=> "account-ownership-information","status"=> "published","editor_id"=> User.first.id,"parent_id"=> ""},
  {"title"=> "Cancellation Policy","content"=> rendered_md("cancellation"),"slug"=> "cancellation","status"=> "published","editor_id"=> User.first.id,"parent_id"=> ""},
  {"title"=> "Support Community","content"=> rendered_md("community"),"slug"=> "community","status"=> "published","editor_id"=> User.first.id,"parent_id"=> ""},
  {"title"=> "Contact Us","content"=> rendered_md("contact"),"slug"=> "contact","status"=> "published","editor_id"=> User.first.id,"parent_id"=> ""},
  {"title"=> "How to manage the account of someone who is incapacitated or has died","content"=> rendered_md("incapacitated"),"slug"=> "incapacitated","status"=> "published","editor_id"=> User.first.id,"parent_id"=> ""},
  {"title"=> "Careers","content"=> rendered_md("jobs"),"slug"=> "jobs","status"=> "published","editor_id"=> User.first.id,"parent_id"=> ""},
  {"title"=> "Partners","content"=> rendered_md("partnership"),"slug"=> "partnership","status"=> "published","editor_id"=> User.first.id,"parent_id"=> ""},
  {"title"=> "Policies","content"=> rendered_md("policies"),"slug"=> "policies","status"=> "published","editor_id"=> User.first.id,"parent_id"=> ""},
  {"title"=> "Privacy Policy","content"=> rendered_md("privacy"),"slug"=> "privacy","status"=> "published","editor_id"=> User.first.id,"parent_id"=> ""},
  {"title"=> "Purpose","content"=> rendered_md("purpose"),"slug"=> "purpose","status"=> "published","editor_id"=> User.first.id,"parent_id"=> ""},
  {"title"=> "Refund Policy","content"=> rendered_md("refund"),"slug"=> "refund","status"=> "published","editor_id"=> User.first.id,"parent_id"=> ""},
  {"title"=> "Service Level Agreement (SLA)","content"=> rendered_md("sla"),"slug"=> "sla","status"=> "published","editor_id"=> User.first.id,"parent_id"=> ""},
  {"title"=> "Security Overview","content"=> rendered_md("security"),"slug"=> "security","status"=> "published","editor_id"=> User.first.id,"parent_id"=> ""},
  {"title"=> "Taxes","content"=> rendered_md("taxes"),"slug"=> "taxes","status"=> "published","editor_id"=> User.first.id,"parent_id"=> ""}
]

files.each do |data|
  Page.create!(data)
end

