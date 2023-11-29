class CreateProperties < ActiveRecord::Migration[7.1]
  def change
    create_table :properties do |t|
      t.string :name, null: false
      t.string :location, null: false
      t.integer :price, null: false
      t.string :city, null: false
      t.text :description, null: false
      t.integer :area, null: false
      t.integer :number_of_rooms, null: false
      t.integer :number_of_bedrooms, null: false
      t.boolean :furnished, default: false
      t.boolean :terrace, default: false
      t.boolean :basement, default: false
      t.boolean :renting, default: false

      t.timestamps
    end
  end
end
