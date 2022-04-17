class CreateMenus < ActiveRecord::Migration[7.0]
  def change
    create_table :menus do |t|
      t.string :name, unique: true
      t.text :description, :limit => 150
      t.decimal :price

      t.timestamps
    end
  end
end
