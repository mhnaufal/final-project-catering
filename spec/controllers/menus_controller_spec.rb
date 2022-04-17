require 'rails_helper'

RSpec.describe MenusController do
  describe 'GET /menus' do
    it '[controller.menu.1] it should return all menus' do
      menu1 = FactoryBot.create(:menu, name: "Nasi Bakar")
      menu2 = FactoryBot.create(:menu, name: "Nasi Uduk")
      menu3 = FactoryBot.create(:menu, name: "Nasi Kuning")

      get :index
      
      parsed_body = JSON.parse(response.body)
      expect(response).to be_successful
      expect(parsed_body.size).to eq(3)
    end
  end

  describe 'GET /menus/:id' do
    it '[controller.menu.2] it should return a menu with the id' do
      menu = FactoryBot.create(:menu)
      
      get :show, params: { id: menu }
      
      expect(assigns(:menu)).to eq menu
      expect(response).to be_successful
    end
  end
end
