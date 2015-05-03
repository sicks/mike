class Corp < ActiveRecord::Base
  has_many :claimables
  has_many :ops

  validates :ccp_id, :name, presence: true

  def sort_val(user)
    unless user.main.nil?
      return self.ccp_id == user.main.corporationID ? 0 : 1
    else
      return 1
    end
  end
end
