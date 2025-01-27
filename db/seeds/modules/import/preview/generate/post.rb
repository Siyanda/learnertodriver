# frozen_string_literal: true

posts = [
  { 'title' => 'Should I wear a seatbelt ?', 'content' => rendered_md('post/should-i-wear-a-seatblet'),
    'slug' => 'should-i-wear-a-seatbelt', 'status' => 'published', 'user_id' => User.first.id },
  { 'title' => 'Test Post', 'content' => rendered_md('post/test-post'), 'slug' => 'test-post', 'status' => 'draft',
    'user_id' => User.first.id }
]

posts.each do |data|
  Post.create!(data)
end
