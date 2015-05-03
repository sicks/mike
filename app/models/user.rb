class User < ActiveRecord::Base

  has_many :auths, dependent: :destroy, inverse_of: :user
  validates_associated :auths
  validates :auths, length: { minimum: 1 }

  has_many :api_keys do
    def persisted
      select{ |api| api if api.persisted? }
    end
  end

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
    api_keys.persisted.map{ |a| a.characters }.flatten.uniq{ |c| c.name } if api_keys.persisted.any?
  end

  def corps
    Corp.where(ccp_id: characters.map{ |c| c.corporationID } ).sort{ |a, b| a.sort_val(self) <=> b.sort_val(self) }
  end

  def main
    characters.find{ |c| c.characterID == main_id } if api_keys.persisted.any?
  end

end
