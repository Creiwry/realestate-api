# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
UserProperty.destroy_all
Property.destroy_all
User.destroy_all

10.times do
  User.create(email: Faker::Internet.email, password: 'password')
end

users = User.all
booleans = [true, false]

20.times do
  Property.create(
    name: Faker::Lorem.words(number: 5).join(' '),
    location: 'Toronto',
    description: Faker::Lorem.paragraphs.join(' '),
    area: Faker::Number.between(from: 20, to: 200),
    number_of_rooms: Faker::Number.between(from: 1, to: 10),
    furnished: booleans.sample,
    terrace: booleans.sample,
    basement: booleans.sample,
    user: users.sample
  )
end
