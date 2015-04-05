require 'rails_helper'
require 'support/omni_auth_test_helper'
include OmniAuthTestHelper

RSpec.describe SessionsController, type: :controller do

  describe "login page" do
    it "returns http success when no user is logged in" do
      session[:user_id] = nil
      get :new
      expect(response).to have_http_status(:success)
    end

    it "should redirect already logged in users to home" do
      session[:user_id] = 1
      get :new
      expect(response).to redirect_to root_path
    end
  end

  describe "google oauth2 callback" do
    before(:each) do
      mock_auth_setup
      get :create, provider: "google_oauth2"
    end

    it "should create a new session" do
      expect(session[:user_id]).to_not eq nil
    end

    it { expect(response).to redirect_to root_path }

  end

  describe "logout" do
    it "destroys the current session" do
      delete :destroy
      expect(session.empty?).to eq true
    end

    it "redirects to the login page" do
      delete :destroy
      expect(response).to redirect_to login_path
    end
  end
end
