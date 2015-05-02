require 'rails_helper'

RSpec.describe Corp, type: :model do
  let(:corp) { build(:corp) }

  it "has a valid factory" do
    expect(corp.valid?).to eq true
  end

  it "is invalid without a name" do
    corp.name = nil

    expect(corp.valid?).to eq false
  end

  it "is invalid without a ccp id" do
    corp.ccp_id = nil

    expect(corp.valid?).to eq false
  end

  describe ".claimables" do
    pending
  end

  describe ".ops" do
    let(:corp) { create(:corp) }
    before(:example) do
      corp.ops.create( attributes_for(:active_op) )
    end

    it "returns a list of ops" do
      expect(corp.ops.count).to eq 1
    end
  end

end
