require 'rails_helper'

RSpec.describe ApiKey, type: :model do

  context "with valid CCP API credentials", :vcr do
    subject(:api_key) { build(:api_key) }

    it "has a valid factory" do
      expect(api_key.valid?).to eq true
    end

    it "is invalid without a vcode" do
      api_key.vcode = nil
      expect(api_key.valid?).to eq false
    end

    it "is invalid without a key id" do
      api_key.key_id = nil
      expect(api_key.valid?).to eq false
    end

    it "is invalid without a user id" do
      api_key.user_id = nil
      expect(api_key.valid?).to eq false
    end

    describe '.expired?' do
      it 'returns false' do
        expect(api_key.expired?).to eq false
      end
    end

    describe '.characters' do
      it 'returns a list of characters on the api' do
        expect(api_key.characters.count).not_to eq 0
      end
    end

    describe '.corporations' do
      it 'returns a list of corporations on the api' do
        expect(api_key.corporations.count).not_to eq 0
      end
    end

    describe '.access_mask' do
      it 'returns the access mask of the provided key' do
        expect(api_key.access_mask).not_to eq false
      end
    end

  end

  context "with invalid CCP API credentials", :vcr do
    subject(:api_key) { build(:api_key_expired) }

    it "is invalid" do
      expect(api_key.valid?).to eq false
    end

    describe '.expired?' do
      it 'returns true' do
        expect(api_key.expired?).to eq true
      end
    end
  end

end
