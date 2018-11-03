class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.string :property_type, null: false
      t.string :property_name, null: false
      t.string :country, null:false
      t.string :state, null:false
      t.string :city, null:false
      t.string :zipcode, null:false
      t.string :address, null:false
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
