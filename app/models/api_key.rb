class ApiKey < ActiveRecord::Base
  belongs_to :user

  validates :key_id, :vcode, :user_id, presence: true
  validate :has_not_expired

  def has_not_expired
    if expired?
      errors.add(:expired, "Expired/Invalid key supplied")
    end
  end

  def expired?
    begin
      eaal.scope = 'account'
      !eaal.APIKeyInfo.key.expires
    rescue
      true
    end
  end

  def characters
    begin
      eaal.scope = 'account'
      eaal.APIKeyInfo.key.characters
    rescue
      false
    end
  end

  def access_mask
    begin
      eaal.scope = 'account'
      eaal.APIKeyInfo.key.access_mask
    rescue
      false
    end
  end

  def corporations
    begin
      result = []
      eaal.scope = 'account'
      eaal.APIKeyInfo.key.characters.each do |c|
        result << OpenStruct.new({ name: c.corporationName, ccp_id: c.corporationID })
      end
      result
    rescue
      false
    end
  end
  #private
  def eaal
    EAAL.cache = EAAL::Cache::FileCache.new
    @api ||= EAAL::API.new( key_id, vcode )
  end

end
