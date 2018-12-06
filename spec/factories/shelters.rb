FactoryBot.define do
  factory :shelter do
    location { Faker::Address.full_address }
  end
end
