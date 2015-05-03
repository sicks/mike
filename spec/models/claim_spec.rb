require 'rails_helper'

RSpec.describe Claim, type: :model do
  let(:claim) { build(:claim) }

  it "has a valid factory" do
    expect(claim.valid?).to eq true
  end

  it "is invalid without an op" do
    claim.op_id = nil

    expect(claim.valid?).to eq false
  end

  it "is invalid without a claimable" do
    claim.claimable_id = nil

    expect(claim.valid?).to eq false
  end

  it "is invalid without a quantity" do
    claim.quantity = nil

    expect(claim.valid?).to eq false
  end
end
