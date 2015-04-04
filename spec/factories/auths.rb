FactoryGirl.define do
  factory :auth do
    association :user, factory: :user, strategy: :build
    uid "123456789"
    provider "google"
  end
end

