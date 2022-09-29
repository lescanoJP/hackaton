FactoryBot.define do
  current_password = Faker::Alphanumeric.alphanumeric(number: 18)

  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    document { CPF.generate }
    password { current_password }
    password_confirmation { current_password }
  end
end
