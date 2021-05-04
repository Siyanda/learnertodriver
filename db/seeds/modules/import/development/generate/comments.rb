files = [
  {"content"=> rendered_md("first-comment"),"post_id"=> Post.first.id,"user_id"=> User.first.id }
]

files.each do |data|
  Comment.create!(data)
end
