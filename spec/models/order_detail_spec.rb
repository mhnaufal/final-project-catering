require 'rails_helper'

RSpec.describe OrderDetail, type: :model do
  context 'Order Detail Model' do
    it '[model.order_detail.0] is valid if factory data valid' do
      order_detail = FactoryBot.build(:order_detail)
      expect(order_detail).to be_valid
    end

    it '[model.order_detail.1] is valid with valid order_detail data' do
      order = FactoryBot.build(:order)
      menu = FactoryBot.build(:menu)
      order_detail = OrderDetail.new(quantity: 3, menu_price: 100.0, order: order, menu: menu)
      expect(order_detail).to be_valid
    end

    it '[model.order_detail.2] is invalid without order data' do
      menu = FactoryBot.build(:menu)
      order_detail = OrderDetail.new(quantity: 3, menu_price: 100.0, order: nil, menu: menu)
      expect(order_detail).to_not be_valid
    end

    it '[model.order_detail.3] is invalid without menu data' do
      order = FactoryBot.build(:order)
      order_detail = OrderDetail.new(quantity: 3, menu_price: 100.0, order: order, menu: nil)
      expect(order_detail).to_not be_valid
    end

    it '[model.order_detail.4] is invalid without quantity' do
      order_detail = FactoryBot.build(:order_detail, quantity: nil)
      order_detail.valid?
      expect(order_detail).to_not be_valid
    end

    it '[model.order_detail.5] is invalid without menu_price' do
      order_detail = FactoryBot.build(:order_detail, menu_price: nil)
      order_detail.valid?
      expect(order_detail).to_not be_valid
      expect(order_detail.errors[:menu_price]).to include("can't be blank")
    end

    it '[model.order_detail.6] is invalid if menu_price is not in decimal form' do
      order_detail = FactoryBot.build(:order_detail, menu_price: "$999")
      order_detail.valid?
      expect(order_detail).to_not be_valid
      expect(order_detail.errors[:menu_price]).to include("is not a number")
    end

    it '[model.order_detail.7] is invalid if quantity is not in integer form' do
      order_detail = FactoryBot.build(:order_detail, quantity: 9.999)
      order_detail.valid?
      expect(order_detail).to_not be_valid
      expect(order_detail.errors[:quantity]).to include("must be an integer")
    end

    it '[model.order_detail.8] is invalid if quantity is not greater than or equal to 1' do
      order_detail = FactoryBot.build(:order_detail, quantity: 0)
      order_detail.valid?
      expect(order_detail).to_not be_valid
      expect(order_detail.errors[:quantity]).to include("must be greater than or equal to 1")
    end
  end
end
