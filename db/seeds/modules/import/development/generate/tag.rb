tags = [
  { 'title' => 'test','content' => rendered_md('tag/test'), 'tagable_id' => Post.first.id, 'tagable_type' => 'Post' },
  { 'title' => 'driving','content' => rendered_md('tag/driving'), 'tagable_id' => Post.first.id, 'tagable_type' => 'Post' }
]

tags.each do |data|
  Tag.create!(data)
end
