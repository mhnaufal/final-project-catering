require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'Category Model' do
    it '[model.category.0] is valid if factory data valid' do
      category = FactoryBot.build(:category)
      expect(category).to be_valid
    end

    it '[model.category.1] is valid with valid category data' do
      category = Category.new(name: "Makanan Utama")
      category.valid?
      expect(category).to be_valid
    end

    it '[model.category.2] is not valid without name' do
      category = FactoryBot.build(:category, name: nil)
      category.valid?
      expect(category.errors[:name]).to include("can't be blank")
      expect(category).to_not be_valid
    end

    it '[model.category.3] is not valid with duplicated name' do
      category1 = FactoryBot.create(:category, name: "Makanan Pembuka")
      category2 = FactoryBot.build(:category, name: "Makanan Pembuka")
      category2.valid?
      expect(category2.errors[:name]).to include("has already been taken")
      expect(category2).to_not be_valid
    end
  end
end
