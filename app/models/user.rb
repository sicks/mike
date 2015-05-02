class User < ActiveRecord::Base

  has_many :auths, dependent: :destroy, inverse_of: :user
  validates_associated :auths
  validates :auths, length: { minimum: 1 }

  has_many :api_keys

  def self.from_omniauth(auth)
    includes(:auths).find_by( auths: { uid: auth.uid, provider: auth.provider } ) || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.auths.new( { uid: auth.uid, provider: auth.provider } )
    end
  end

  def name
    if main.nil?
      "Randy"
    else
      main.name
    end
  end

  def characters
    api_keys.map{ |a| a.characters }.flatten.uniq{ |c| c.name }
  end

  def corporations
    api_keys.map{ |a| a.corporations }.flatten.uniq{ |c| c.name }
  end

  def main
    characters.find{ |c| c.characterID == main_id } if characters.any?
  end

end
