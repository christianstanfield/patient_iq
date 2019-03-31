FactoryBot.define do
  factory :department do
    association :company
    name { Faker::Company.profession }
  end
end
