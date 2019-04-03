FactoryBot.define do
  factory :department do
    association :company
    sequence(:name) { |n| "#{Faker::Company.profession} #{n}" }
  end
end
