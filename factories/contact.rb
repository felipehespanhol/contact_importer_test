FactoryBot.define do
  factory :contact do
    name do
      [
        "Grover Sanford V",
        "Pres Slyvia Marquardt",
        "Cliff Senger",
        "Leighann Yundt",
        "Marjorie Swaniawski",
      ].sample
    end
    date_of_birth { Faker::Date.birthday(min_age: 18, max_age: 65) }
    phone { ['(+57) 320 432 05 09', '(+57) 320-432-05-09'].sample }
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
