comments = [
  { 'content' => rendered_md('comment/first-comment'), 'post_id' => Post.first.id, 'user_id' => User.first.id }
]

comments.each do |data|
  Comment.create!(data)
end
