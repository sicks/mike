require 'rails_helper'

RSpec.describe Claimable, type: :model do
  let(:claimable) { build(:claimable) }

  it "has a valid factory" do
    expect(claimable.valid?).to eq true
  end

  it "is invalid without a corp" do
    claimable.corp_id = nil

    expect(claimable.valid?).to eq false
  end

  it "is invalid without a weight" do
    claimable.weight = nil

    expect(claimable.valid?).to eq false
  end
end
