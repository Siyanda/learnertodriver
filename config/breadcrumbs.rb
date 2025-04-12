# frozen_string_literal: true

# Dashboard
crumb :root do
  link 'Home', root_path
end

# User list
crumb :users do
  link 'Users', user_path
end

# Profile
crumb :user do |user|
  link user.username, user
end

# Post list
crumb :posts do
  link 'Posts', posts_path
end

# Post
crumb :post do |post|
  link post.title, post
  parent :posts
end

# New Post
crumb :new_post do
  link 'New Post', posts_path
  parent :posts
end

# Page
crumb :page do |page|
  link page.title, page
end

# Quiz list
crumb :quizzes do
  link 'Tests', quizzes_path
end

# Quiz
crumb :quiz do |quiz|
  link quiz.title, quiz
  parent :quizzes
end

# Quiz list
crumb :evaluations do
  link 'Tests', quizzes_path
end

# Quiz
crumb :evaluation do |evaluation|
  link "New #{evaluation.title} Quiz", quiz_evaluations_path
  parent :evaluations
end
