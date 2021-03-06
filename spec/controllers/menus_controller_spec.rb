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

      expect(parsed_body["message"]).to include("❌ No Menu with the id = #{menu_id}")
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST /menus' do
    it '[controller.menu.4] it should save the menu to the database' do
      valid_attributes = FactoryBot.attributes_for(:menu, name: 'Es Teh', description: "An English tea with blocks of North Poles' ice shard", price:  1999.0)

      post :create, params: valid_attributes

      parsed_body = JSON.parse(response.body)

      expect(response).to be_successful
      expect(parsed_body["message"]).to include("✅ Successfully create a Menu")
      expect(parsed_body["payload"]).to_not eq(nil)
    end

    it '[controller.menu.5] is invalid if the given menu data is incorrect' do
      invalid_attributes = FactoryBot.attributes_for(:menu, name: nil)

      post :create, params: invalid_attributes

      parsed_body = JSON.parse(response.body)

      expect(response).to have_http_status(:bad_request)
      expect(parsed_body["message"]).to include("❌ Error while creating a menu")
      expect(parsed_body["payload"]).to eq(nil)
    end

    it "[controller.menu.6] is invalid if the menus' name already exists" do
      menu1 = FactoryBot.create(:menu, name: "Es Teh")
      menu2 = FactoryBot.attributes_for(:menu, name: "Es Teh")

      post :create, params: menu2

      parsed_body = JSON.parse(response.body)

      expect(response).to have_http_status(:conflict)
      expect(parsed_body["message"]).to include("❌ Menu with that name already exists")
    end
  end

  describe 'PATCH /menus/:id' do
    it '[controller.menu.7] it should return the menu with updated field(s)' do
      menu = FactoryBot.create(:menu)

      patch :update, params: { id: menu, name: 'Kopi Jos' }

      parsed_body = JSON.parse(response.body)

      expect(response).to be_successful
      expect(parsed_body["message"]).to include("✅ Successfully update a Menu")
      expect(parsed_body["payload"]).to_not eq(nil)
    end

    it '[controller.menu.8] is invalid if the given updated field(s) are incorect' do
      menu = FactoryBot.create(:menu)

      post :update, params: { id: menu, name: nil }

      parsed_body = JSON.parse(response.body)

      expect(response).to have_http_status(:bad_request)
      expect(parsed_body["message"]).to include("❌ Error while updating a menu")
      expect(parsed_body["payload"]).to eq(nil)
    end

    it "[controller.menu.9] is invalid if the menus' name already exists" do
      menu1 = FactoryBot.create(:menu, name: "Es Teh")
      menu2 = FactoryBot.attributes_for(:menu, name: "Es Teh Panas")

      post :update, params: { id: menu2, name: "Es Teh" }

      parsed_body = JSON.parse(response.body)

      expect(response).to have_http_status(:conflict)
      expect(parsed_body["message"]).to include("❌ Menu with that name already exists")
    end
  end

  describe 'DELETE /menus/:id' do
    it '[controller.menu.10] it should succeed delete the menu' do
      deleted_menu = FactoryBot.create(:menu)
      
      delete :destroy, params: { id: deleted_menu }

      parsed_body = JSON.parse(response.body)

      expect(response).to be_successful
      expect(parsed_body["message"]).to include("✅ Successfully delete a menu")
    end
  
    it '[controller.menu.11] is invalid if menu with the given id is not exists' do
      deleted_menu = 0

      delete :destroy, params: { id: deleted_menu }

      parsed_body = JSON.parse(response.body)

      expect(response).to have_http_status(:not_found)
      expect(parsed_body["message"]).to include("❌ Error while deleting a menu. Menu not found")
      expect(parsed_body["payload"]).to eq(nil)
    end
  end
end
