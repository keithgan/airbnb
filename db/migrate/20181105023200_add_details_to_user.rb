class AddDetailsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :gender, :string
    add_column :users, :birthday, :date
    add_column :users, :phone_number, :string
    add_column :users, :description, :string
  end
end