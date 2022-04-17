require 'rails_helper'

RSpec.describe Menu, type: :model do
  context 'Menu Model' do
    it '[model.menu.0] is valid if factory data valid' do
      menu = FactoryBot.build(:menu)
      expect(menu).to be_valid
    end

    it '[model.menu.1] is valid with valid menu data' do
      menu = Menu.new(name: "Nasi Bakar", description: "Rice that needs a fire extinguisher", price: 3333.3)
      menu.valid?
      expect(menu).to be_valid
    end

    it '[model.menu.2] is not valid without name' do
      menu = FactoryBot.build(:menu, name: nil)
      menu.valid?
      expect(menu.errors[:name]).to include("can't be blank")
      expect(menu).to_not be_valid
    end

    it '[model.menu.3] is not valid without description' do
      menu = FactoryBot.build(:menu, description: nil)
      menu.valid?
      expect(menu.errors[:description]).to include("can't be blank")
      expect(menu).to_not be_valid
    end

    it '[model.menu.4] is not valid without price' do
      menu = FactoryBot.build(:menu, price: nil)
      menu.valid?
      expect(menu.errors[:price]).to include("can't be blank")
      expect(menu).to_not be_valid
    end

    it '[model.menu.5] is not valid if description more than 150 characters' do
        menu = FactoryBot.build(:menu, description: "Lorem ipsum dolor, sit amet consectetur 
          adipisicing elit. Odio, hic voluptatibus sequi eligendi atque excepturi maxime, incidunt 
          necessitatibus quam consequuntur nostrum nihil qui magnam numquam dolore repellat? Assumenda 
          nobis deleniti error quia quas, eum quis labore unde cumque optio iure quam, minima aliquid 
          suscipit corporis voluptas cupiditate in animi laborum, iusto tempore voluptatum sint consequatur? 
          Alias quaerat beatae dolorem in commodi amet quo ex obcaecati adipisci? Qui ratione tempore 
          perspiciatis voluptate ullam, reprehenderit deleniti pariatur totam culpa neque ipsam laudantium, 
          enim, nihil est dolor minima minus! Quia at officiis nam tempore laborum laboriosam libero facere animi, 
          eum ipsum distinctio, quas illo officia optio quisquam commodi consequatur sit est architecto modi.
          Nam repellendus consequatur alias delectus, iste fuga reiciendis, libero quod ad quas eaque nobis. 
          Unde, blanditiis? Et ut atque nostrum. Ipsum libero tempora voluptatum dolorem suscipit asperiores, 
          magnam optio blanditiis ex dignissimos veritatis, ab, saepe non deserunt consequuntur itaque dicta.Z")
        menu.valid?
        expect(menu.errors[:description]).to include("is too long (maximum is 150 characters)")
        expect(menu).to_not be_valid
    end

    it '[model.menu.6] is not valid if name is duplicated' do
      menu1 = FactoryBot.create(:menu, name: "Nasi Duduk")
      menu2 = FactoryBot.build(:menu, name: "Nasi Duduk")
      menu2.valid?
      expect(menu2.errors[:name]).to include("has already been taken")
      expect(menu2).to_not be_valid
    end

    it '[model.menu.7] is not valid if price is less than 0.01' do
      menu = FactoryBot.build(:menu, price: 0.009)
      menu.valid?
      expect(menu.errors[:price]).to include("must be greater than or equal to 0.01")
      expect(menu).to_not be_valid
    end

    it '[model.menu.8] is not valid if price not in decimal type' do
      menu = FactoryBot.build(:menu, price: "$1000.0")
      menu.valid?
      expect(menu.errors[:price]).to include("is not a number")
      expect(menu).to_not be_valid
    end
end

end
