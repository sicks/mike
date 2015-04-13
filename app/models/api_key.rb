class ApiKey < ActiveRecord::Base
  belongs_to :user

  validates :key_id, :vcode, :user_id, presence: true
end
