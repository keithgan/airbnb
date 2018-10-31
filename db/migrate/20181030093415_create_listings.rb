class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.string :accommodation_type, null: false
      t.string :accommodation_name, null: false
      t.string :accommodation_location, null: false
      t.integer :no_of_guests, null: false
      t.integer :no_of_bedrooms, null: false
      t.integer :no_of_beds, null: false
      t.integer :no_of_bathrooms, null: false
      t.string :amenities
      t.integer :price_per_night, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
