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
  link user.username, user_path
end

# Edit profile
crumb :edit_user do |user|
  link 'Edit', edit_user_path
  parent :user, user
end

# Change password
crumb :edit_user_password do |user|
  link 'Password', edit_user_password_path
  parent :user, user
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

# Page show
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

# Admin dashboard
crumb :admin_root do
  link 'Admin', admin_path
end

# Admin resource list
crumb :admin_index do |model|
  link admin_plural(model), [:admin, model]
  parent :admin_root
end

# Admin record
crumb :admin_record do |record|
  link admin_label(record), [:admin, record]
  parent :admin_index, record.class
end

# Admin new record
crumb :admin_new do |model|
  link "New #{model.model_name.human}", [:new, :admin, model.model_name.singular_route_key.to_sym]
  parent :admin_index, model
end

# Admin edit record
crumb :admin_edit do |record|
  link 'Edit', [:edit, :admin, record]
  parent :admin_record, record
end
