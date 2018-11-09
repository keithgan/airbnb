class Listing < ApplicationRecord
    belongs_to :user
    has_many :reservations, dependent: :destroy
    mount_uploaders :images, ImageUploader
   
    scope :omnisearch, -> (query) { where(" city ILIKE ? OR country ILIKE ?", "#{query}", "#{query}") }    
end
