FactoryGirl.define do
  factory :user do

    after( :build ) do |user|
      user.auths << build(:auth, user: user)
    end
    after( :create ) do |user|
      user.auths.each { |auth| auth.save! }
    end
  end
end

