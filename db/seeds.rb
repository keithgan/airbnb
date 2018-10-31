# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Seed Users
user = {}
user['password'] = '1234'

ActiveRecord::Base.transaction do
  20.times do 
    user['first_name'] = Faker::Name.first_name 
    user['last_name'] = Faker::Name.last_name
    user['email'] = Faker::Internet.email

    User.create(user)
  end
end 

# Seed Listings
listing = {}
uids = []
User.all.each { |u| uids << u.id }

ActiveRecord::Base.transaction do
  40.times do 
    listing['accommodation_type'] = ["House", "Entire Floor", "Condominium", "Villa", "Townhouse", "Castle", "Treehouse", "Igloo", "Yurt", "Cave", "Chalet", "Hut", "Tent", "Other"].sample
    listing['accommodation_name'] = Faker::App.name
    listing['accommodation_location'] = Faker::Address.country
    listing['no_of_guests'] = rand(1..10)
    listing['no_of_bedrooms'] = rand(1..5)
    listing['no_of_beds'] = rand(1..6)
    listing['no_of_bathrooms'] = rand(1..2)
    listing['price_per_night'] = rand(80..500)
    listing['user_id'] = uids.sample

    Listing.create(listing)
  end
end