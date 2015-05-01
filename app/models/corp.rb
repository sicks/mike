class Corp < ActiveRecord::Base
  has_many :claimables
  has_many :ops

  validates :ccp_id, :name, presence: true
end
