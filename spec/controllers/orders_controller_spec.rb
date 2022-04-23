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

  describe 'POST /orders' do
    it '[controller.order.4] it should save the new order to the database' do
      valid_attributes = FactoryBot.attributes_for(:order, status: 'NEW')

      post :create, params: valid_attributes

      parsed_body = JSON.parse(response.body)

      expect(response).to be_successful
      expect(parsed_body["message"]).to include("✅ Successfully create a new order")
      expect(parsed_body["payload"]).to_not eq(nil)
    end

    it '[controller.order.5] is invalid if the given order data is incorrect' do
      invalid_attributes = FactoryBot.attributes_for(:order, email: nil, status: 'NEW')

      post :create, params: invalid_attributes

      parsed_body = JSON.parse(response.body)

      expect(response).to have_http_status(:bad_request)
      expect(parsed_body["message"]).to include("❌ Error while creating an order")
      expect(parsed_body["payload"]).to eq(nil)
    end
  end

  describe 'PATCH /orders/status/:id' do
    it '[controller.order.6] it should change the order status to PAID' do
      order = FactoryBot.create(:order, status: 'NEW')

      patch :change_status, params: { id: order, new_status: 'PAID' } 

      parsed_body = JSON.parse(response.body)

      expect(response).to be_successful
      expect(parsed_body["message"]).to include("✅ Successfully update an Order")
      expect(parsed_body["payload"]).to_not eq(nil)
    end

    it '[controller.order.7] it should change the order status to CANCELLED' do
      order = FactoryBot.create(:order, status: 'NEW')

      patch :change_status, params: { id: order, new_status: 'CANCELLED' } 

      parsed_body = JSON.parse(response.body)

      expect(response).to be_successful
      expect(parsed_body["message"]).to include("✅ Successfully update an Order")
      expect(parsed_body["payload"]).to_not eq(nil)
    end

    it '[controller.order.8] is invalid if order with the given id is not exists' do
      order = 0

      patch :change_status, params: { id: order, new_status: 'PAID' }

      parsed_body = JSON.parse(response.body)

      expect(response).to have_http_status(:not_found)
      expect(parsed_body["message"]).to include("❌ No order with the id exists")
      expect(parsed_body["payload"]).to eq(nil)
    end
  end
end