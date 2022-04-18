require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'Order Model' do
    it '[model.order.0] is valid if factory data valid' do
      order = FactoryBot.build(:order)
      expect(order).to be_valid
    end

    it '[model.order.1] is valid with valid order data' do
      order = Order.new(email: "meli@gigih.com", total: 100.0, status: 0)
      order.valid?
      expect(order).to be_valid
    end

    it '[model.order.2] is invalid if email format is not valid' do
      order = Order.new(email: "hello@gigih", total: 1000.0, status: 0)
      order.valid?
      expect(order).to_not be_valid
      expect(order.errors[:email]).to include('wrong email format!')
    end

    it '[model.order.3] is invalid if without email' do
      order = FactoryBot.build(:order, email: nil)
      order.valid?
      expect(order).to_not be_valid
      expect(order.errors[:email]).to include("can't be blank")
    end
  end
end
