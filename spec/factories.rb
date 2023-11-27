FactoryBot.define do
  factory(:user) do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { 'password' }
  end
end

FactoryBot.define do
  factory(:property) do
    name { Faker::Lorem.words(number: 5).join(' ') }
    location { Faker::Address.city }
    description { Faker::Lorem.paragraphs.join(' ') }
    area { Faker::Number.between(from: 20, to: 200) }
    number_of_rooms { Faker::Number.between(from: 4, to: 10) }
    number_of_rooms { Faker::Number.between(from: 1, to: 4) }
    furnished { [true, false].sample }
    terrace { [true, false].sample }
    basement { [true, false].sample }
    renting { [true, false].sample }
    user { create(:user) }
  end
end

FactoryBot.define do
  factory(:user_property) do
    user { create(:user) }
    property { create(:property) }
  end
end