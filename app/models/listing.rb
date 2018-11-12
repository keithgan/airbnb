class Listing < ApplicationRecord
    belongs_to :user
    has_many :reservations, dependent: :destroy
    mount_uploaders :images, ImageUploader

    scope :omnisearch, -> (query) { where(" property_name ILIKE ? or property_type ILIKE ? or city ILIKE ? OR country ILIKE ? ", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%") }
end

