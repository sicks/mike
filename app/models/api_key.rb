class ApiKey < ActiveRecord::Base
  belongs_to :user

  validates :key_id, :vcode, :user_id, presence: true
  validate :has_not_expired

  after_save :create_corps

  def has_not_expired
    if expired?
      errors.add(:expired, "Expired/Invalid key supplied")
    end
  end

  def expired?
    begin
      eaal.scope = 'account'
      !eaal.APIKeyInfo.key.expires
    rescue EAAL::Exception::EveAPIException
      true
    end
  end

  def characters
    begin
      eaal.scope = 'account'
      eaal.Characters.characters
    rescue EAAL::Exception::EveAPIException
      false
    end
  end

  def access_mask
    begin
      eaal.scope = 'account'
      eaal.APIKeyInfo.key.accessMask
    rescue EAAL::Exception::EveAPIException
      false
    end
  end

  private
  def eaal
    EAAL.cache = EAAL::Cache::FileCache.new
    @api ||= EAAL::API.new( key_id, vcode )
  end

  def create_corps
    characters.each do |c|
      Corp.find_or_create_by(name: c.corporationName, ccp_id: c.corporationID)
    end
  end
end
