class User < ActiveRecord::Base

  has_many :auths, dependent: :destroy, inverse_of: :user

  validates_associated :auths
  validates :auths, length: { minimum: 1 }


  def self.from_omniauth(auth)
    includes(:auths).find_by( auths: { uid: auth.uid, provider: auth.provider } ) || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.auths.new( { uid: auth.uid, provider: auth.provider } )
    end
  end
end
