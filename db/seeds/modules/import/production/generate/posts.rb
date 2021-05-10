files = [
  { 'title' => 'Should I wear a seatbelt ?', 'content' => rendered_md('should-i-wear-a-seatblet'), 'slug' => 'should-i-wear-a-seatbelt', 'status' => 'published', 'author_id' => User.first.id, 'created_at' => 55.months.ago, 'updated_at' => 3.days.ago },
  { 'title' => 'Test Post', 'content' => rendered_md('test-post'), 'slug' => 'test-post', 'status' => 'draft', 'author_id' => User.first.id }
]

files.each do |data|
  Post.create!(data)
end
