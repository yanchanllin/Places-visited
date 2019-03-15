class User < ApplicationRecord
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable
  
    devise :omniauthable, :omniauth_providers => [:facebook]
    validates :name, presence: true
    has_many :places
  
    def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name
      end
    end

end 