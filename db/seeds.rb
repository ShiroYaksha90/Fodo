# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# User.create!(name: 'Admin User',
#             email: 'admin@example.com',
#             password: 'password',
#             password_confirmation: 'password',
#             admin: true)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@example.com"
  password = 'password'
  User.create!(name: name,
              email: email,
              password: password,
              password_confirmation: password)
end

users = User.all
users[2..20].each do |user|
  name = Faker::Food.dish
  description = Faker::Food.description
  r = Recipe.create!(name: name,
                    description: description,
                    user_id: user.id)
  3.times do
    ingredient = Faker::Food.ingredient
    r.ingredients.create(name: ingredient)
  end
end