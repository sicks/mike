require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do

  controller do
    def index
    end
  end

  context "no user is logged in" do
    it "redirects to the login page" do
      session[:user_id] = nil
      get :index
      expect(response).to redirect_to login_path
    end
  end

  context "the logged in user requires a valid API key" do
    it "redirects to the new api key page" do
      session[:user_id] = create(:user).id
      get :index
      expect(response).to redirect_to new_api_key_path
    end
  end

end
