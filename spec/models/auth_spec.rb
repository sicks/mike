require 'rails_helper'

RSpec.describe Auth, type: :model do

  it 'should have a valid facotry' do
    auth = create( :auth )
    expect(auth.valid?).to eq true
  end

  it 'should be invalid without a user' do
    auth =  build( :auth, user_id: nil )
    expect( auth.valid? ).to eq false
  end

  it 'should be invalid without a uid' do
    auth = build( :auth, uid: nil )
    expect( auth.valid? ).to eq false
  end

  it 'should be invalid without a provider' do
    auth = build( :auth, provider: nil )
    expect( auth.valid? ).to eq false
  end

end
