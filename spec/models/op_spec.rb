require 'rails_helper'

RSpec.describe Op, type: :model do
  let(:op) { build(:active_op) }

  it "is invalid without a corp" do
    op.corp_id = nil

    expect(op.valid?).to eq false
  end

  it "is invalid without a name" do
    op.name = nil

    expect(op.valid?).to eq false
  end

  it "is invalid without a start" do
    op.start = nil

    expect(op.valid?).to eq false
  end

  describe ".participants" do
    it "lists users who participated in the op"
  end

  describe ".totalclaims" do
    it "returns the total sum of all claims for this op"
  end
end
