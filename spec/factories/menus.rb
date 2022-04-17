FactoryBot.define do
  factory :menu do
    name { "Menu Default" }
    description { "This is the default menu that not suppose to be sold to the customer" }
    price { "1000.0" }
  end
end
