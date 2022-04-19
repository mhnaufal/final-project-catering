FactoryBot.define do
  factory :order_detail do
    order
    menu
    quantity { Faker::Number.number(digits: 1) }
    menu_price { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
  end
end
