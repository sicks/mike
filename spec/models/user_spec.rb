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

  context "when no main is set" do
    let!(:no_main_user) { create(:user) }

    describe ".name" do
      it "returns Randy", :vcr do
        expect(no_main_user.name).to eq "Randy"
      end
    end
  end

  context "when a main is set" do
    let!(:main_set_user) { create(:user) }
    before(:example) do
      main_set_user.api_keys.create( attributes_for(:api_key) )
      main_set_user.main_id = main_set_user.characters.find{ |c| c.name == "Sicks" }.characterID
    end

    describe ".name" do
      it "returns the name of the selected character", :vcr do
        expect(main_set_user.name).to eq "Sicks"
      end
    end
  end

  context "when user has multiple api keys" do
    let!(:multi_api_user) { create(:user) }
    before(:example) do
      2.times { multi_api_user.api_keys.create( attributes_for(:api_key) ) }
    end

    describe ".characters" do
      it "returns a unique list of characters", :vcr do
        names = multi_api_user.characters.map{ |c| c.name }
        expect(names.count("Sicks")).to eq 1
      end
    end

    describe ".corporations" do
      it "returns a unique list of characters", :vcr do
        names = multi_api_user.corps.map{ |c| c.name }
        expect(names.count("Doom Generation")).to eq 1
      end
    end
  end
end
