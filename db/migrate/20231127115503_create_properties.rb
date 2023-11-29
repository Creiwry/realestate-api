class CreateProperties < ActiveRecord::Migration[7.1]
  def change
    create_table :properties do |t|
      t.string :name
      t.string :location
      t.string :city
      t.text :description
      t.integer :area
      t.integer :number_of_rooms
      t.integer :number_of_bedrooms
      t.boolean :furnished, default: false
      t.boolean :terrace, default: false
      t.boolean :basement, default: false
      t.boolean :renting, default: false

      t.timestamps
    end
  end
end
