class Claimable < ActiveRecord::Base
  belongs_to :corp

  validates :corp_id, :name, :weight, presence: true
end
