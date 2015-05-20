FactoryGirl.define do
  factory :user do
    main_id "924610593"
    after( :build ) do |user|
      user.auths << build(:google_oauth2, user: user)
    end
    after( :create ) do |user|
      user.auths.each { |auth| auth.save! }
    end
  end
end

