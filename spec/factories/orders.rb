FactoryBot.define do
  factory :order do
    email { Faker::Internet.email }
    total { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    status { 0 }
  end
end
