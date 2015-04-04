class Auth < ActiveRecord::Base
  belongs_to :user

  validates :user, :uid, :provider, presence: true
end
