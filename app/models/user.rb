class User < ApplicationRecord
  devise :database_authenticatable, :rememberable,
         :omniauthable, omniauth_providers: %i[google_oauth2]
  validates :uid, uniqueness: { scope: :provider }
  has_many :affiliated_group, dependent: :destroy

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
