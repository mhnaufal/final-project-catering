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

    it '[model.order.4] is invalid with unknown order.status type' do
      expect { Order.new(email: "hello@gigih.com", total: 100.0, status: 3) }.to raise_error(ArgumentError)
    end
    
    it '[model.order.5] is invalid with non decimal total' do
      order = FactoryBot.build(:order, total: "$1000.0")
      order.valid?
      expect(order).to_not be_valid
      expect(order.errors[:total]).to include("is not a number")
    end

    it '[model.order.6] is invalid if total is less than 0.01' do
      order = FactoryBot.build(:order, total: 0.009)
      order.valid?
      expect(order).to_not be_valid
      expect(order.errors[:total]).to include("must be greater than or equal to 0.01")
    end

    it '[model.order.7] is invalid if no total is not given' do
      order = FactoryBot.build(:order, total: nil)
      order.valid?
      expect(order).to_not be_valid
      expect(order.errors[:total]).to include("can't be blank")
    end

    it '[model.order.8] is invalid if no status is not given' do
      order = FactoryBot.build(:order, status: nil)
      order.valid?
      expect(order).to_not be_valid
      expect(order.errors[:status]).to include("can't be blank")
    end
  end
end
