class Op < ActiveRecord::Base
  belongs_to :corp
  belongs_to :user
  has_many :claims
  has_many :participants

  validates :name, :corp_id, presence: true

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
    read_attribute(:start).strftime("%Y/%m/%d %H:%M")
  end

  def start_short
    read_attribute(:start).strftime("%m/%d %H:%M")
  end
end
