# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# 20.times do
#   User.create first_name: Faker::Name.first_name,
#             last_name: Faker::Name.last_name,
#             email: Faker::Internet.email,
#             password: "12345678",
#             password_confirmation: "12345678"
# end
#
# 20.times do
#   Idea.create title: Faker::Book.title,
#               body: Faker::Hipster.paragraph,
#               user: User.all.sample
#
# end
#
# 20.times do
#   Review.create body: Faker::Hipster.paragraph,
#                 idea: Idea.all.sample,
#                 user: User.all.sample
# end

1000.times do
  Like.create idea: Idea.all.sample,
              user: User.all.sample
end
puts 'data created'
