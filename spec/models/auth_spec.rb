require 'rails_helper'

RSpec.describe Auth, type: :model do

  it 'has a valid factory' do
    auth = create( :auth )
    expect(auth.valid?).to eq true
  end

  it 'is invalid without a user' do
    auth =  build( :auth, user_id: nil )
    expect( auth.valid? ).to eq false
  end

  it 'is invalid without a uid' do
    auth = build( :auth, uid: nil )
    expect( auth.valid? ).to eq false
  end

  it 'is invalid without a provider' do
    auth = build( :auth, provider: nil )
    expect( auth.valid? ).to eq false
  end

end
