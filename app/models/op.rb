class Op < ActiveRecord::Base
  belongs_to :corp
  belongs_to :user
  has_many :claims, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :users, through: :participants

  validates :name, :corp_id, :start_time,  presence: true

  def self.active
    unconcluded.where("start_time < ?", DateTime.now)
  end

  def self.future
    unconcluded.where("start_time > ?", DateTime.now)
  end

  def self.unconcluded
    where(end_time: nil)
  end

  def self.concluded
    where.not(end_time: nil)
  end

  def self.prepare(user)
    Op.new(name: user.name+"'s Op", start_time: DateTime.now)
  end

  def start_time
    read_attribute(:start_time).strftime("%Y/%m/%d %H:%M") unless read_attribute(:start_time).nil?
  end

  def start_short
    read_attribute(:start_time).strftime("%H:%M %m/%d")
  end

  def end_time
    read_attribute(:end_time).strftime("%Y/%m/%d %H:%M") unless read_attribute(:end_time).nil?
  end

  def end_short
    read_attribute(:end_time).strftime("%H:%M %m/%d")
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
