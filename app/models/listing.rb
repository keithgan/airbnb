class Listing < ApplicationRecord
    belongs_to :user
    has_many :reservations, dependent: :destroy
    paginates_per 20
    mount_uploaders :images, ImageUploader
end
