require 'rails_helper'

RSpec.describe MenusController do
  describe 'GET /menus' do
    it '[controller.menu.1] it should return all menus & 200 HTTP code' do
      menu1 = FactoryBot.create(:menu, name: "Nasi Bakar")
      menu2 = FactoryBot.create(:menu, name: "Nasi Uduk")
      menu3 = FactoryBot.create(:menu, name: "Nasi Kuning")

      get :index

      parsed_body = JSON.parse(response.body)

      expect(response).to be_successful
      expect(parsed_body["payload"].size).to eq(3)
    end
  end

  describe 'GET /menus/:id' do
    it '[controller.menu.2] it should return a menu with the given menu_id & 200 HTTP code' do
      menu = FactoryBot.create(:menu)

      get :show, params: { id: menu }

      expect(assigns(:menu)).to eq(menu)
      expect(response).to be_successful
    end

    it '[controller.menu.3] it should return an empty menu & 404 HTTP code because there is no menu with the given menu_id' do
      menu_id = 0

      get :show, params: { id: menu_id }

      parsed_body = JSON.parse(response.body)

      expect(parsed_body["message"]).to include("No Menu with the id = #{menu_id}")
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST /menus' do
    it '[controller.menu.4] it should save the menu to the database' do
      valid_attributes = FactoryBot.attributes_for(:menu, name: 'Es Teh', description: "An English tea with blocks of North Poles' ice shard", price:  1999.0)

      post :create, params: valid_attributes

      parsed_body = JSON.parse(response.body)

      expect(response).to be_successful
      expect(parsed_body["message"]).to include("Successfully create a Menu")
      expect(parsed_body["payload"]).to_not eq(nil)
    end

    it '[controller.menu.5] is invalid if the given menu data is incorrect' do
    invalid_attributes = FactoryBot.attributes_for(:menu, name: nil)

      post :create, params: invalid_attributes

      parsed_body = JSON.parse(response.body)

      expect(response).to have_http_status(:bad_request)
      expect(parsed_body["message"]).to include("Error while creating a menu")
      expect(parsed_body["payload"]).to eq(nil)
    end
  end
end
