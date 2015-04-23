require 'rails_helper'

RSpec.describe Auth, type: :model do

  it 'has a valid factory' do
    auth = create( :google_oauth2 )
    expect(auth.valid?).to eq true
  end

  it 'is invalid without a user' do
    auth =  build( :google_oauth2, user_id: nil )
    expect( auth.valid? ).to eq false
  end

  it 'is invalid without a uid' do
    auth = build( :google_oauth2, uid: nil )
    expect( auth.valid? ).to eq false
  end

  it 'is invalid without a provider' do
    auth = build( :google_oauth2, provider: nil )
    expect( auth.valid? ).to eq false
  end

end
