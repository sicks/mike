require 'rails_helper'

RSpec.describe User, type: :model do

  it 'has a valid factory' do
    user = create(:user)
    expect( user.valid? ).to eq true
  end

  it 'is invalid without any auths' do
    no_auth_user = build(:user)
    no_auth_user.auths.destroy_all
    expect( no_auth_user.valid? ).to eq false
  end

  describe ".characters" do
    it "returns a unique list of characters", :vcr do
      multi_char_user = create(:user)
      2.times { multi_char_user.api_keys.create( attributes_for(:api_key) ) }

      names = multi_char_user.characters.map{ |c| c.name }
      expect(names.count("Sicks")).to eq 1
    end
  end

  describe ".corporations" do
    it "returns a unique list of characters", :vcr do
      multi_corp_user = create(:user)
      2.times { multi_corp_user.api_keys.create( attributes_for(:api_key) ) }

      names = multi_corp_user.corporations.map{ |c| c.name }
      expect(names.count("Doom Generation")).to eq 1
    end
  end
end
