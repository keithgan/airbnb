class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.date :check_in, null:false
      t.date :check_out, null:false
      t.integer :no_of_guests, null: false
      t.integer :total_price
      t.references :listing, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
