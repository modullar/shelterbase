FactoryBot.define do
  factory :adoption_request do

    email { Faker::Internet.email }
    name { Faker::Name.name.downcase }
    telephone_number { Faker::PhoneNumber.phone_number }

    association :animal, factory: :animal
  end
end
