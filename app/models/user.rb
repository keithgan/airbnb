class User < ApplicationRecord
  include Clearance::User

  has_many :authentications, dependent: :destroy
  has_many :listings, dependent: :destroy
  has_many :reservations, dependent: :destroy

  enum status: { customer: 0, moderator: 1, superadmin: 2 }
  mount_uploader :avatar, AvatarUploader

  def self.create_with_auth_and_hash(authentication, auth_hash)
      user = self.create!(
      first_name: auth_hash["info"]["name"].split(" ")[0],
      last_name: auth_hash["info"]["name"].split(" ")[1],
      email: auth_hash["info"]["email"],
      password: SecureRandom.hex(10)
    )
    user.authentications << authentication
    return user
  end

  # grab google to access google for user data
  def google_token
    x = self.authentications.find_by(provider: 'google_oauth2')
    return x.token unless x.nil?
  end
end
