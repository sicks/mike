FactoryGirl.define do
  factory :google_oauth2, class: Auth do
    association :user, factory: :user, strategy: :build
    uid "123456789"
    provider "google_oauth2"
  end
end

