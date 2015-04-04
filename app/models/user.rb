class User < ActiveRecord::Base

  has_many :auths, inverse_of: :user

  validates_associated :auths
  validates :auths, length: { minimum: 1 }
end
