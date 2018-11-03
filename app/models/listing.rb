class Listing < ApplicationRecord
    belongs_to :user
    paginates_per 20
    mount_uploaders :images, ImageUploader
end
