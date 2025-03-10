FactoryBot.define do
  factory :task do
    name { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Lorem.paragraph }
    association :project
  end
end
