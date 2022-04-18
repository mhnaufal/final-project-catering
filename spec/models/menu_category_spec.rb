require 'rails_helper'

RSpec.describe MenuCategory, type: :model do
  context 'MenuCategory Model' do
    it '[model.menu_category.0] is valid if factory data valid' do
      menu_category = FactoryBot.build(:menu_category)
      expect(menu_category).to be_valid
    end

    it '[model.menu_category.1] is valid with valid menu_category data' do
      menu = FactoryBot.build(:menu)
      category = FactoryBot.build(:category)
      menu_category = MenuCategory.new(menu: menu, category: category)
      expect(menu_category).to be_valid
    end
  end
end
