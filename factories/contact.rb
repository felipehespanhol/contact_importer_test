FactoryBot.define do
  factory :contact do
    name { Faker::Name.name }
    date_of_birth { Faker::Date.birthday(min_age: 18, max_age: 65) }
    phone { Faker::PhoneNumber.phone_number }
    address { Faker::Address.full_address }
    email { Faker::Internet.email }

    mastercard

    trait :american_express do
      credit_card { "371449635398431" }
      franchise { "American Express" }
    end

    trait :mastercard do
      credit_card { "5555555555554444" }
      franchise { "MasterCard" }
    end

    trait :visa do
      credit_card { "4111111111111111" }
      franchise { "Visa" }
    end
  end
end
