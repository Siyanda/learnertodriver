crumb :root do
  link "Dashboard", dashboard_path
end

# User list
crumb :users do
  link "Users", user_path
end

# User
crumb :user do |user|
  link user.name.first, user
  parent :users
end


# Post list
crumb :posts do
  link "Posts", posts_path
end

# Post
crumb :post do |post|
  link post.title, post
  parent :posts
end

# Quiz list
crumb :quizzes do
  link "Tests", quizzes_path
end

# Quiz
crumb :quiz do |quiz|
  link quiz.title, quiz
  parent :quizzes
end

# Quiz list
crumb :evaluations do
  link "Tests", quiz_evaluations_path
end

# Quiz
crumb :evaluation do |evaluation|
  link "New Quiz", quiz_evaluations_path
  parent :evaluations
end
