FactoryBot.define do
  factory :user do


    email { Faker::Internet.email }
    username { Faker::Name.name.downcase }
    password { '123' }
  end

  factory :worker, parent: :user, class: 'Worker' do
    association :shelter, factory: :shelter
  end
  
  factory :client, parent: :user, class: 'Client' do
  end

end
