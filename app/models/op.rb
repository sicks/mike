class Op < ActiveRecord::Base
  belongs_to :corp
  belongs_to :user
  has_many :claims
  has_many :participants

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
end
