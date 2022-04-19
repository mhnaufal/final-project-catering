FactoryBot.define do
  factory :order_detail do
    order { nil }
    menu { nil }
    quantity { 1 }
    menu_price { "9.99" }
  end
end
