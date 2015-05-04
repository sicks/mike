class Op < ActiveRecord::Base
  belongs_to :corp
  belongs_to :user
  has_many :claims, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :users, through: :participants

  validates :name, :corp_id, :start,  presence: true

  def self.active
    unconcluded.where("start < ?", DateTime.now)
  end

  def self.future
    unconcluded.where("start > ?", DateTime.now)
  end

  def self.unconcluded
    where(end: nil)
  end

  def start
    read_attribute(:start).strftime("%Y/%m/%d %H:%M") unless read_attribute(:start).nil?
  end

  def start_short
    read_attribute(:start).strftime("%H:%M %m/%d")
  end

  def subtotal
    claims.reduce(0) do |total, claim|
      total + claim.value
    end
  end

  def total
    participants.reduce(0) do |total, participant|
      total + participant.value
    end
  end
end
