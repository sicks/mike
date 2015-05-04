class Participant < ActiveRecord::Base
  belongs_to :user
  belongs_to :op

  validates :user_id, :op_id, :mod, presence: true
end
