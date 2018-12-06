FactoryBot.define do
  factory :animal do
    medical_condition { Faker::Lorem.sentence(3) }
    temp_name { Faker::Name.first_name }
    race { Faker::Address.country }

    association :shelter, factory: :shelter

  end
end
