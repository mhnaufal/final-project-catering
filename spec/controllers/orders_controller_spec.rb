require 'rails_helper'

RSpec.describe OrdersController do
  describe 'GET /orders' do
    it '[controller.order.1] it should return all orders' do
      order1 = FactoryBot.create(:order)
      order2 = FactoryBot.create(:order)
      order3 = FactoryBot.create(:order)

      get :index

      parsed_body = JSON.parse(response.body)

      expect(response).to be_successful
      expect(parsed_body.size).to eq(3)
    end

    describe 'GET /orders/:id' do
      it '[controller.order.2] it should return an order with the given id' do
        order = FactoryBot.create(:order)

        get :show, params: { id: order }

        expect(assigns(:order)).to eq(order)
        expect(response).to be_successful
      end

      it '[controller.order.3] it should return an empty order' do
        order_id = 0

        get :show, params: { id: order_id }

        parsed_body = JSON.parse(response.body)

        expect(parsed_body).to include({ "message" => "❌ No order with the id = #{order_id}" })
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end