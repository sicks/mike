require 'rails_helper'

RSpec.describe Participant, type: :model do
  let(:participant) { build(:participant) }

  it 'has a valid factory' do
    expect(participant.valid?).to eq true
  end

  it 'is invalid without an op' do
    participant.op_id = nil

    expect(participant.valid?).to eq false
  end

  it 'is invalid without a user' do
    participant.user_id = nil

    expect(participant.valid?).to eq false
  end
end
