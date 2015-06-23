require 'rails_helper'

RSpec.describe Op, type: :model do
  let(:op) { build(:active_op) }

## validations
  it "is invalid without a corp" do
    op.corp_id = nil

    expect(op.valid?).to eq false
  end

  it "is invalid without a name" do
    op.name = nil

    expect(op.valid?).to eq false
  end

  it "is invalid without a start time" do
    op.start_time = nil

    expect(op.valid?).to eq false
  end

## scopes
  describe "self.unconcluded" do
    it "returns only unconcluded ops"
  end

  describe "self.concluded" do
    it "returns only concluded ops"
  end

  describe "self.active" do
    it "returns only unconcluded ops which have started"
  end

  describe "self.future" do
    it "returns only unconcluded ops which have yet to start"
  end

  describe "self.unpaid" do
    it "returns only concluded ops which have yet to be paid"
  end

  describe "self.paid" do
    it "returns only concluded ops which have been paid out"
  end

## class methods


## associations
  describe ".participants" do
    it "lists users who participated in the op"
  end

  describe ".claims" do
    it "lists claimables associated with this op"
  end

  describe ".subtotal" do
    it "sums the weight of each claim multiplied by its quantity"
  end

  describe ".total" do
    it "sums the product of each participant mod and this op's subtital"
  end
end
