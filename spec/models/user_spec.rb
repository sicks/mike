require 'rails_helper'

RSpec.describe User, type: :model do

  it 'has a valid factory' do
    user = create( :user )
    expect( user.valid? ).to eq true
  end

  it 'is invalid without any auths' do
    no_auth_user = build(:user)
    no_auth_user.auths.destroy_all
    expect( no_auth_user.valid? ).to eq false
  end

end
