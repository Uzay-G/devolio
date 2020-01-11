# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# users
99.times do |n|
  name  = Faker::Name.name
  email = "halcyon#{n+1}@ethereal.org"
  password = "password"
  User.create!(username:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end


# posts
users = User.order(:created_at).take(6)
50.times do |i|
  title = "Devol.io #{i}"
  users.each { |user| user.posts.create!(body: Faker::Lorem.sentence(word_count: 5), title: title) }
end


