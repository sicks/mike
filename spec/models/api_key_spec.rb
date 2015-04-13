require 'rails_helper'

RSpec.describe ApiKey, type: :model do

  it "has a valid factory" do
    api_key = build(:api_key)
    expect(api_key.valid?).to eq true
  end

  it "is invalid without a vcode" do
    api_key = build(:api_key, vcode: nil)
    expect(api_key.valid?).to eq false
  end

  it "is invalid without a key id" do
    api_key = build(:api_key, key_id: nil)
    expect(api_key.valid?).to eq false
  end

  it "is invalid without a user id" do
    api_key = build(:api_key, user_id: nil)
    expect(api_key.valid?).to eq false
  end

end
