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
  User.create(
    email: Faker::Internet.email,
    password: 'password',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
end

users = User.all
booleans = [true, false]
cities = [
  "Paris",
  "Nice",
  "Toulouse",
  "Bordeaux",
  "Marseille",
  "Nantes",
  "Lyon",
]

20.times do
  number_of_rooms = Faker::Number.between(from: 1, to: 10)
  number_of_bedrooms = number_of_rooms > 3 ? number_of_rooms - 2 : 0
  Property.create(
    name: Faker::Lorem.words(number: 1).join(''),
    location: Faker::Address.street_address,
    city: cities.sample,
    price: 50000,
    description: Faker::Lorem.paragraphs.join(' '),
    area: Faker::Number.between(from: 20, to: 200),
    number_of_rooms:,
    number_of_bedrooms:,
    furnished: booleans.sample,
    terrace: booleans.sample,
    basement: booleans.sample,
    renting: booleans.sample,
    user: users.sample
  )
end
