FactoryBot.define do
  factory :user do
    association :department
    first_name { Faker::Superhero.prefix }
    last_name  { Faker::Superhero.name }
    phone      { Faker::Number.number(10) }
    address    { Faker::Address.full_address }
    email      { Faker::Internet.email }
    password   { Faker::Internet.password(8) }
    salary     { Faker::Number.number(5) }
    bonus      { Faker::Number.number(4) }
    role       { :employee }
  end
end
