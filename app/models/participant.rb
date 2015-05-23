class Participant < ActiveRecord::Base
  belongs_to :user
  belongs_to :op

  validates :user_id, :op_id, :mod, presence: true

  def value
    (op.subtotal * mod).to_i
  end

  def name
    user.name
  end
end
