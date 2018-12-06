FactoryBot.define do
  factory :shelter do
    location { Faker::Address.full_address }
    name { Faker::FunnyName.name }
  end
end
