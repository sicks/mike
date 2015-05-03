class Claim < ActiveRecord::Base
  belongs_to :op
  belongs_to :claimable

  validates :op_id, :claimable_id, :quantity, presence: true
end
